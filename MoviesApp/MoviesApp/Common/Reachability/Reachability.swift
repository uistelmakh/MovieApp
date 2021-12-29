import Foundation
import SystemConfiguration

/// Класс для отслеживания интернета
final class Reachability {
    var hostname: String?
    var isRunning = false
    var isReachableOnWWAN: Bool
    var reachability: SCNetworkReachability?
    var reachabilityFlags = SCNetworkReachabilityFlags()
    let reachabilitySerialQueue = DispatchQueue(label: "ReachabilityQueue")
    init(hostname: String) throws {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, hostname) else {
            throw Network.NetworkError.failedToCreateWith(hostname)
        }
        self.reachability = reachability
        self.hostname = hostname
        isReachableOnWWAN = true
        try start()
    }
    init() throws {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let reachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            throw Network.NetworkError.failedToInitializeWith(zeroAddress)
        }
        self.reachability = reachability
        isReachableOnWWAN = true
        try start()
    }
    var status: Network.Status {
        return  !isConnectedToNetwork ? .unreachable :
                isReachableViaWiFi    ? .wifi :
                isRunningOnDevice     ? .wwan : .unreachable
    }
    var isRunningOnDevice: Bool = {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }()
    deinit { stop() }
}

extension Reachability {

    func start() throws {
        guard let reachability = reachability, !isRunning else { return }
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = Unmanaged<Reachability>.passUnretained(self).toOpaque()
        guard SCNetworkReachabilitySetCallback(reachability, callout, &context) else { stop()
            throw Network.NetworkError.failedToSetCallout
        }
        guard SCNetworkReachabilitySetDispatchQueue(reachability, reachabilitySerialQueue) else { stop()
            throw Network.NetworkError.failedToSetDispatchQueue
        }
        reachabilitySerialQueue.async { self.flagsChanged() }
        isRunning = true
    }

    func stop() {
        defer { isRunning = false }
        guard let reachability = reachability else { return }
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        self.reachability = nil
    }

    var isConnectedToNetwork: Bool {
        return isReachable &&
               !isConnectionRequiredAndTransientConnection &&
               !(isRunningOnDevice && isWWAN && !isReachableOnWWAN)
    }

    var isReachableViaWiFi: Bool {
        return isReachable && isRunningOnDevice && !isWWAN
    }

    /// Флаги, указывающие доступность имени или адреса сетевого узла, в том числе, требуется ли подключение и может ли потребоваться какое-либо вмешательство пользователя при установлении соединения.
    var flags: SCNetworkReachabilityFlags? {
        guard let reachability = reachability else { return nil }
        var flags = SCNetworkReachabilityFlags()
        return withUnsafeMutablePointer(to: &flags) {
            SCNetworkReachabilityGetFlags(reachability, UnsafeMutablePointer($0))
            } ? flags : nil
    }

    /// Cравнивает текущие флаги с предыдущими флагами и, если они изменены, публикует уведомление об изменении флага
    func flagsChanged() {
        guard let flags = flags, flags != reachabilityFlags else { return }
        reachabilityFlags = flags
        NotificationCenter.default.post(name: .flagsChanged, object: self)
    }

    /// Указанное имя или адрес узла могут быть достигнуты через временное соединение, такое как PPP.
    var transientConnection: Bool { return flags?.contains(.transientConnection) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети.
    var isReachable: Bool { return flags?.contains(.reachable) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети, но сначала необходимо установить соединение. Если этот флаг установлен, флаг kSCNetworkReachabilityFlagsConnectionOnTraffic, флаг kSCNetworkReachabilityFlagsConnectionOnDemand или флаг kSCNetworkReachabilityFlagsIsWWAN также обычно устанавливаются для указания типа требуемого подключения. Если пользователь должен вручную установить соединение, также устанавливается флаг kSCNetworkReachabilityFlagsInterventionRequired.
    var connectionRequired: Bool { return flags?.contains(.connectionRequired) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети, но сначала необходимо установить соединение. Любой трафик, направленный на указанное имя или адрес, инициирует соединение.
    var connectionOnTraffic: Bool { return flags?.contains(.connectionOnTraffic) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети, но сначала необходимо установить соединение.
    var interventionRequired: Bool { return flags?.contains(.interventionRequired) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети, но сначала необходимо установить соединение. Соединение будет установлено "По требованию" с помощью программного интерфейса CFSocketStream (информацию об этом см. в разделе Дополнения к сокетам CFStream). Другие функции не позволят установить соединение.
    var connectionOnDemand: Bool { return flags?.contains(.connectionOnDemand) == true }

    /// Указанное имя или адрес узла - это тот, который связан с сетевым интерфейсом в текущей системе.
    var isLocalAddress: Bool { return flags?.contains(.isLocalAddress) == true }

    /// Сетевой трафик на указанное имя или адрес узла не будет проходить через шлюз, а будет перенаправляться непосредственно на один из интерфейсов в системе.
    var isDirect: Bool { return flags?.contains(.isDirect) == true }

    /// С указанным именем или адресом узла можно связаться через сотовую связь, такую как EDGE или GPRS.
    var isWWAN: Bool { return flags?.contains(.isWWAN) == true }

    /// Указанное имя или адрес узла можно получить, используя текущую конфигурацию сети, но сначала необходимо установить соединение. Если этот флаг установлен
    /// Указанное имя или адрес узла могут быть достигнуты через временное соединение, такое как PPP.
    var isConnectionRequiredAndTransientConnection: Bool {
        return (flags?.intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]) == true
    }
}

func callout(reachability: SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutableRawPointer?) {
    guard let info = info else { return }
    DispatchQueue.main.async {
        Unmanaged<Reachability>
            .fromOpaque(info)
            .takeUnretainedValue()
            .flagsChanged()
    }
}

extension Notification.Name {
    static let flagsChanged = Notification.Name("FlagsChanged")
}


