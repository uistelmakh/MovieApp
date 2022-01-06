//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 09.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var routingAssistant: RoutingAssistantProtocol = RoutingAssistant.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Проверка подключения к хосту
        checkInternetConnection()
        
        // Загрузка стартового экрана
        createStartVC()
        return true
    }
    
    // MARK: - Создание стартового экрана
    private func createStartVC() {
        let navigationController = UINavigationController()
        routingAssistant.setRootNavigationController(navigationController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        routingAssistant.constructStartViewController() { startViewController in
            if let startViewController = startViewController {
                navigationController.viewControllers = [startViewController]
                //navigationController.isNavigationBarHidden = true
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            } else {
                fatalError("Failure startViewControllerCreating")
            }
        }
            NotificationCenter.default.addObserver(self, selector: #selector(self.statusManager), name: .flagsChanged, object: nil)
    }
}

// MARK: - Networking check
extension AppDelegate {
    @objc func statusManager(_ notification: Notification) {
        createStartVC()
    }
    
    func checkInternetConnection() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.NetworkError {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
}
