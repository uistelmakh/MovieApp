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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        routingAssistant.constructStartViewController() { startViewController in
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
