import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var walletCoordinator: FornaxWalletController!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let walletCoordinator = FornaxWalletController()

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = walletCoordinator.rootViewController
    window.makeKeyAndVisible()

    self.walletCoordinator = walletCoordinator
    self.window = window

    return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    self.walletCoordinator.reset(animated: false)
  }
}
