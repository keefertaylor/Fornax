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
    print("TODO: Launch the restore wallet flow")
  }
}
