// Copyright Keefer Taylor, 2018

import Foundation
import TezosKit
import UIKit

/**
 * A mediator class which will coordinate interactions between Fornax services and view controllers.
 */
public class WalletCoordinator: NSObject {
  /** The root controller at the base of the hierarchy. */
  public let rootViewController: WelcomeViewController

  /** The wallet that is being interacted with. */
  public var activeWallet: Wallet?

  /** The Tezos gateway client. */
  public let tezosClient: TezosClient

  public override init() {
    self.activeWallet = nil

    self.tezosClient = TezosClient()

    self.rootViewController = WelcomeViewController()

    super.init()

    self.rootViewController.delegate = self
  }

  /**
   * Reset all state by clearing all sensitive data and removing all UI.
   */
  public func reset(animated: Bool) {
    self.rootViewController.dismiss(animated: animated)
    self.activeWallet = nil
  }

  private func pushWalletController(navigationController: UINavigationController, wallet: Wallet) {
    let walletViewController = WalletViewController(wallet: wallet,
                                                    tezosClient: self.tezosClient)
    walletViewController.delegate = self
    navigationController.pushViewController(walletViewController, animated: true)
  }
}

extension WalletCoordinator: WelcomeViewControllerDelegate {
  public func welcomeViewControllerDidRequestRestoreWallet(_: WelcomeViewController) {
    let restoreWalletViewController = RestoreWalletViewController()
    restoreWalletViewController.delegate = self

    let navController = UINavigationController(rootViewController: restoreWalletViewController)
    self.rootViewController.present(navController, animated: true)
  }

  public func welcomeViewControllerDidRequestNewWallet(_: WelcomeViewController) {
    guard let mnemonic = MnemonicUtil.generateMnemonic() else {
      HUDManager.showErrorAndDismiss("Unknown Error\nPlease try again?")
      return
    }
    let newWalletViewController = NewWalletViewController(mnemonic: mnemonic)
    newWalletViewController.delegate = self

    let navController = UINavigationController(rootViewController: newWalletViewController)
    self.rootViewController.present(navController, animated: true)
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
    HUDManager.show()
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else {
        return
      }

      self.activeWallet = Wallet(mnemonic: mnemonic, passphrase: passphrase)
      DispatchQueue.main.async {
        guard let activeWallet = self.activeWallet,
          let navController = restoreWalletViewController.navigationController else {
          HUDManager.showErrorAndDismiss("Something went wrong.")
          return
        }
        HUDManager.dismiss()

        self.pushWalletController(navigationController: navController, wallet: activeWallet)
      }
    }
  }
}

extension WalletCoordinator: WalletViewControllerDelegate {
  public func walletViewControllerDidPressLock(_ walletViewController: WalletViewController) {
    self.activeWallet = nil
    walletViewController.dismiss(animated: true)

    HUDManager.showInfoAndDismiss("Securely removed wallet.")
  }
}

extension WalletCoordinator: NewWalletViewControllerDelegate {
  public func newWalletViewControllerDidRequestClose(_ newWalletViewController: NewWalletViewController) {
    newWalletViewController.dismiss(animated: true)
  }

  public func newWalletViewControllerDidRequestNewWallet(_ newWalletViewController: NewWalletViewController,
                                                         mnemonic: String,
                                                         passphrase: String) {
    // Generating a wallet is a cryptographic process and can take time so show a spinner.
    HUDManager.show()
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else {
        return
      }

      let wallet = Wallet(mnemonic: mnemonic, passphrase: passphrase)
      DispatchQueue.main.async {
        guard let wallet = wallet,
          let navController = newWalletViewController.navigationController else {
          HUDManager.showErrorAndDismiss("Something went wrong.")
          return
        }
        HUDManager.dismiss()

        let confirmWalletViewController = ConfirmWalletViewController(wallet: wallet)
        confirmWalletViewController.delegate = self

        navController.pushViewController(confirmWalletViewController, animated: true)
      }
    }
  }
}

extension WalletCoordinator: ConfirmWalletViewControllerDelegate {
  public func confirmWalletViewControllerDidRequestDismiss(_ confirmWalletViewController: ConfirmWalletViewController) {
    confirmWalletViewController.dismiss(animated: true)
  }

  public func confirmWalletViewControllerDidConfirmWallet(_ confirmWalletViewController: ConfirmWalletViewController,
                                                          wallet: Wallet) {
    guard let navigationController = confirmWalletViewController.navigationController else {
      HUDManager.showErrorAndDismiss("Something went wrong.")
      return
    }
    self.pushWalletController(navigationController: navigationController, wallet: wallet)
  }
}
