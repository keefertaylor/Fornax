import Foundation
import MnemonicKit
import UIKit

public protocol NewWalletViewControllerDelegate: class {
  func newWalletViewControllerDidRequestClose(_ newWalletViewController: NewWalletViewController)
  func newWalletViewControllerDidRequestNewWallet(_ newWalletViewController: NewWalletViewController)
}

public class NewWalletViewController: UIViewController {
  public weak var delegate: NewWalletViewControllerDelegate?

  public init(mnemonic: String) {
    let newWalletView = NewWalletView(mnemonic: mnemonic)

    super.init(nibName: nil, bundle: nil)

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

  public func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView) {
    self.delegate?.newWalletViewControllerDidRequestNewWallet(self)
  }
}
