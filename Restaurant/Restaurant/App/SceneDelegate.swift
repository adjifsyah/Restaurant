//
//  SceneDelegate.swift
//  Restaurant
//
//  Created by Adji Firmansyah on 03/06/22.
//

import UIKit
import LocalAuthentication

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var userDefault: UserDefaults = .standard
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        firstAppLaunch()
        window?.makeKeyAndVisible()
        
    }
    
    func firstAppLaunch() {
        let isUserExist: Bool = (userDefault.value(forKey: "user")) != nil
        if isUserExist {
            print("isUserExist", isUserExist)
            handleBiometrics(isExist: isUserExist)
        } else {
            let viewController = handleViewController(isExist: isUserExist)
            handleRoot(viewController: viewController)
        }
    }
    
    func handleBiometrics(isExist: Bool) {
        let context = LAContext()
        var authError: NSError?
        let reasonString = "To access the secure data"
        context.localizedFallbackTitle = "Use Passcode"
        var resViewController: UIViewController = UIViewController()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { (success, error) in
                guard success else { return }
                print("IS EXIST", isExist)
                DispatchQueue.main.async {
                    let viewController = self.handleViewController(isExist: isExist)
                    
                    resViewController = viewController
                }
            }
        } else {
            let alert = UIAlertController(title: "Biometry unavailable",
                                          message: "Your device is not configured for biometric authentication.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            resViewController.present(alert, animated: true)
        }
    }
    
    private func handleViewController(isExist: Bool) -> UIViewController {
        let homeView = RSTHomeTableViewController()
        let loginView = LoginViewController()
        let _ = handleRoot(viewController: isExist ? homeView : loginView)
        return isExist ? homeView : loginView
    }
    
    private func handleRoot(viewController: UIViewController) {
        let rootVC = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = rootVC
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

