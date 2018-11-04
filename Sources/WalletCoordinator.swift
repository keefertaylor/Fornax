import Foundation
import SVProgressHUD
import TezosKit
import UIKit

/**
 * A mediator class which will coordinate interactions between Fornax services and view controllers.
 */
public class WalletCoordinator {

  /** The root controller at the base of the hierarchy. */
  public let rootViewController: WelcomeViewController

  /** The wallet that is being interacted with. */
  public var activeWallet: Wallet?

  public init() {
    self.rootViewController = WelcomeViewController()
    self.rootViewController.delegate = self

    self.activeWallet = nil
  }

  /**
   * Reset all state by clearing all sensitive data and removing all UI.
   */
  public func reset(animated: Bool) {
    self.rootViewController.dismiss(animated: animated)
    self.activeWallet = nil
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

  public func restoreWalletViewControllerDidRequestRestoreWallet(_ restoreWalletViewController: RestoreWalletViewController,
                                                                 mnemonic: String,
                                                                 passphrase: String) {
    // Generating a wallet is a cryptographic process and can take time so show a spinner.
    SVProgressHUD.show()
    // TODO: Use weakself to prevent retain cycles.
    DispatchQueue.global(qos: .userInitiated).async {
      self.activeWallet = Wallet(mnemonic: mnemonic, passphrase: passphrase)
      DispatchQueue.main.async {
        if self.activeWallet != nil {
          SVProgressHUD.dismiss()
          // TODO: Push a wallet VC.
        } else {
          SVProgressHUD.showError(withStatus: "Something went wrong.")
        }
      }
    }
  }
}
