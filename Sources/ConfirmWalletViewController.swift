import Foundation
import TezosKit
import UIKit

public protocol ConfirmWalletViewControllerDelegate: class {
  func confirmWalletViewControllerDidRequestDismiss(_ confirmWalletViewController: ConfirmWalletViewController)
  func confirmWalletViewControllerDidConfirmWallet(_ confirmWalletViewController: ConfirmWalletViewController,
                                                   wallet: Wallet)
}

public class ConfirmWalletViewController: UIViewController {
  public weak var delegate: ConfirmWalletViewControllerDelegate?

  private let wallet: Wallet

  public init(wallet: Wallet) {
    self.wallet = wallet

    super.init(nibName: nil, bundle: nil)

    self.navigationItem.title = "Confirm Wallet"

    // TODO: Use a proper icon here.
    let closeButton = UIBarButtonItem(title: "X",
                                      style: .plain,
                                      target: self,
                                      action: #selector(closeButtonPressed))
    self.navigationItem.rightBarButtonItem = closeButton

    let inputWalletView = InputWalletView()
    inputWalletView.inputWalletDelegate = self
    self.view = inputWalletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  @objc public func closeButtonPressed() {
    self.delegate?.confirmWalletViewControllerDidRequestDismiss(self)
  }
}

extension ConfirmWalletViewController: InputWalletViewDelegate {
  public func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                                 mnemonic: String,
                                                 passphrase: String) {
    // Confirm the wallet is actually matching before making delegate callback.
    // TODO: Weakself
    HUDManager.show()
    DispatchQueue.global(qos: .userInitiated).async {
      guard let wallet = Wallet(mnemonic: mnemonic, passphrase: passphrase) else {
        HUDManager.showErrorAndDismiss("Something went wrong\nTry again?")
        return
      }

      guard wallet == self.wallet else {
        HUDManager.showErrorAndDismiss("Wallets didn't match.\nTry again?")
        return
      }

      HUDManager.dismiss()

      DispatchQueue.main.async {
        self.delegate?.confirmWalletViewControllerDidConfirmWallet(self, wallet: self.wallet)
      }
    }
  }
}
