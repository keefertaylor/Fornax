import Foundation
import UIKit
import SVProgressHUD
import TezosKit

public protocol RestoreWalletViewControllerDelegate: class {
  /**
   * @note The mnemonic in this delegate call is guaranteed to be a valid BIP39 mnemonic.
   */
  func restoreWalletViewControllerDidRequestRestoreWallet(_ restoreWalletViewController: RestoreWalletViewController,
                                                          mnemonic: String,
                                                          passphrase: String)
  func restoreWalletViewControllerDidRequestClose(_ restoreWalletViewController: RestoreWalletViewController)
}

public class RestoreWalletViewController: UIViewController {
  public weak var delegate: RestoreWalletViewControllerDelegate?

  public init() {
    super.init(nibName: nil, bundle: nil)

    let inputWalletView = InputWalletView()
    inputWalletView.inputWalletDelegate = self
    self.view = inputWalletView
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}

extension RestoreWalletViewController: InputWalletViewDelegate {

  public func inputWalletViewDidPressClose(_ inputWalletView: InputWalletView) {
    self.delegate?.restoreWalletViewControllerDidRequestClose(self)
  }

  public func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                                 mnemonic: String,
                                                 passphrase: String) {
    guard MnemonicUtil.validate(mnemonic: mnemonic) else {
      SVProgressHUD.showError(withStatus: "Invalid Mnemonic.\nDouble check and try again?")
      return
    }
    self.delegate?.restoreWalletViewControllerDidRequestRestoreWallet(self,
                                                                      mnemonic: mnemonic,
                                                                      passphrase: passphrase)
  }
}
