import Foundation
import SVProgressHUD
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

    let inputWalletView = InputWalletView()
    inputWalletView.inputWalletDelegate = self
    self.view = inputWalletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

extension ConfirmWalletViewController: InputWalletViewDelegate {
  public func inputWalletViewDidPressClose(_ inputWalletView: InputWalletView) {
    self.delegate?.confirmWalletViewControllerDidRequestDismiss(self)
  }

  public func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                                 mnemonic: String,
                                                 passphrase: String) {
    // Confirm the wallet is actually matching before making delegate callback.
    SVProgressHUD.show()
    DispatchQueue.global(qos: .userInitiated).async {
      guard let wallet = Wallet(mnemonic: mnemonic, passphrase: passphrase) else {
        SVProgressHUD.showError(withStatus: "Something went wrong\nTry again?")
        return
      }

      guard wallet == self.wallet else {
        SVProgressHUD.showError(withStatus: "Wallets didn't match.\nTry again?")
        return
      }

      SVProgressHUD.dismiss()
      self.delegate?.confirmWalletViewControllerDidConfirmWallet(self, wallet: self.wallet)
    }
  }
}
