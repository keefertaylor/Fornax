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
    print("FYI: Mnemonic is: \(mnemonic)")

    super.init(nibName: nil, bundle: nil)

    let newWalletView = NewWalletView(mnemonic: mnemonic)
    newWalletView.delegate = self
    self.view = newWalletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

extension NewWalletViewController: NewWalletViewDelegate {
  public func newWalletViewDidPressClose(_ newWalletView: NewWalletView) {
    self.delegate?.newWalletViewControllerDidRequestClose(self)
  }

  public func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView,
                                          passphrase: String) {
    self.delegate?.newWalletViewControllerDidRequestNewWallet(self,
                                                              mnemonic: self.mnemonic,
                                                              passphrase: passphrase)
  }
}
