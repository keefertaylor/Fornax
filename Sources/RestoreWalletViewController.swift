import Foundation
import UIKit
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

    self.navigationItem.title = "RESTORE WALLET"

    let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonPressed))
    self.navigationItem.rightBarButtonItem = closeButton

    let inputWalletView = InputWalletView()
    inputWalletView.inputWalletDelegate = self
    self.view = inputWalletView
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }

  @objc public func closeButtonPressed() {
    self.delegate?.restoreWalletViewControllerDidRequestClose(self)
  }
}

extension RestoreWalletViewController: InputWalletViewDelegate {
  public func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                                 mnemonic: String,
                                                 passphrase: String) {
    guard MnemonicUtil.validate(mnemonic: mnemonic) else {
      HUDManager.showErrorAndDismiss("Invalid Mnemonic.\nDouble check and try again?")
      return
    }
    self.delegate?.restoreWalletViewControllerDidRequestRestoreWallet(self,
                                                                      mnemonic: mnemonic,
                                                                      passphrase: passphrase)
  }
}
