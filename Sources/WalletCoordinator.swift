import Foundation
import UIKit
import SVProgressHUD

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

  public func welcomeViewControllerDidRequestNewWallet(_ welcomeViewController: WelcomeViewController) {
    let notYetImplementedMessage = "Not yet implemented."
    SVProgressHUD.showError(withStatus: notYetImplementedMessage)
    print(notYetImplementedMessage)
  }
}

extension WalletCoordinator: RestoreWalletViewControllerDelegate {
  public func restoreWalletViewControllerDidRequestClose(_ restoreWalletViewController: RestoreWalletViewController) {
    restoreWalletViewController.dismiss(animated: true)
  }

  public func restoreWalletViewControllerDidRequestRestoreWallet(_ restoreWalletViewController: RestoreWalletViewController) {
    let notYetImplementedMessage = "Not yet implemented."
    SVProgressHUD.showError(withStatus: notYetImplementedMessage)
    print(notYetImplementedMessage)
  }
}
