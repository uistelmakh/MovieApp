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
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)-> Bool{
        
        // Загрузка стартового экрана
        createStartVC()
        return true
    }
    
    // MARK: - Создание стартового экрана
    private func createStartVC() {
        let navigationController = UINavigationController()
        routingAssistant.setRootNavigationController(navigationController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        routingAssistant.constructStartViewController() { [weak self] startViewController in
            guard let self = self else { return }
            if let startViewController = startViewController {
                navigationController.viewControllers = [startViewController]
                navigationController.isNavigationBarHidden = true
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
            } else {
                fatalError("Failure startViewControllerCreating")
            }
        }
    }
}
