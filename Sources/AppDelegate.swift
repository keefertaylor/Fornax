import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var walletCoordinator: WalletCoordinator!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let walletCoordinator = WalletCoordinator()

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = walletCoordinator.rootViewController
    window.makeKeyAndVisible()

    self.walletCoordinator = walletCoordinator
    self.window = window

    self.setUpAppearances()

    return true
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    self.walletCoordinator.reset(animated: false)
  }

  private func setUpAppearances() {
    UINavigationBar.appearance().barTintColor =  UIColor.tezosDarkBlue
    UINavigationBar.appearance().barStyle =  .black
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.accentColor]
    UINavigationBar.appearance().isTranslucent = false

    HUDManager.configure()
  }
}
