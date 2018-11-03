import Foundation
import UIKit

/**
 * A mediator class which will coordinate interactions between Fornax services and view controllers.
 */
public class WalletCoordinator {

  /** The root controller at the base of the hierarchy. */
  public let rootViewController: WelcomeViewController

  public init() {
    self.rootViewController = WelcomeViewController()
    self.rootViewController.delegate = self
  }

  /**
   * Reset all state by clearing all sensitive data and removing all UI.
   */
  public func reset(animated: Bool) {
    self.rootViewController.dismiss(animated: animated)
  }
}

extension WalletCoordinator: WelcomeViewControllerDelegate {
  public func welcomeViewControllerDidRequestRestoreWallet(_ welcomeViewController: WelcomeViewController) {
    let restoreWalletViewController = RestoreWalletViewController()
    restoreWalletViewController.delegate = self
    self.rootViewController.present(restoreWalletViewController, animated: true)
  }
}

extension WalletCoordinator: RestoreWalletViewControllerDelegate {
  public func restoreWalletViewControllerDidRequestClose(_ restoreWalletViewController: RestoreWalletViewController) {
    restoreWalletViewController.dismiss(animated: true)
  }

  public func restoreWalletViewControllerDidRequestRestoreWallet(_ restoreWalletViewController: RestoreWalletViewController) {
    print("TODO: Restore a wallet here")
  }
}
