import Foundation
import UIKit

public protocol NewWalletViewControllerDelegate: class {
  func newWalletViewControllerDidRequestClose(_ newWalletViewController: NewWalletViewController)
  func newWalletViewControllerDidRequestNewWallet(_ newWalletViewController: NewWalletViewController,
                                                  mnemonic: String,
                                                  passphrase: String)
}

public class NewWalletViewController: UIViewController {
  public weak var delegate: NewWalletViewControllerDelegate?

  private let mnemonic: String

  public init(mnemonic: String) {
    self.mnemonic = mnemonic
    super.init(nibName: nil, bundle: nil)

    self.navigationItem.title = "New Wallet"

    let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonPressed))
    self.navigationItem.rightBarButtonItem = closeButton

    let newWalletView = NewWalletView(mnemonic: mnemonic)
    newWalletView.delegate = self
    self.view = newWalletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  @objc public func closeButtonPressed() {
    self.delegate?.newWalletViewControllerDidRequestClose(self)
  }
}

extension NewWalletViewController: NewWalletViewDelegate {
  public func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView,
                                          passphrase: String) {
    self.delegate?.newWalletViewControllerDidRequestNewWallet(self,
                                                              mnemonic: self.mnemonic,
                                                              passphrase: passphrase)
  }
}
