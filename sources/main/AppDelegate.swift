import Coordinator
import Dependency
import Keychain
import Kit
import OAuth2
import os
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate
{
    @Dependency private var oauth2Configuration: OAuth2Configuration?
    private var isConfigurationInjected: Bool {
        oauth2Configuration != nil
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard isConfigurationInjected else {
            fatalError("Misconfigured application. Check the logs for additional details.")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if connectingSceneSession.role == UISceneSession.Role.windowApplication {
            let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            config.delegateClass = SceneDelegate.self
            return config
        }
        fatalError("Unhandled scene role \(connectingSceneSession.role)")
    }
}
