import MyTumblr
import OAuth2
import os
import UIKit

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, delegateClassName())

private func delegateClassName() -> String
{
    do {
        let configuration = try OAuth2Configuration.createFrom(filename: "tumblr.plist")
        try TumblrInjection().injectDependencies(configuration: configuration)
    } catch {
        fatalError("🚨 \(error)")
    }
    return NSStringFromClass(AppDelegate.self)
}
