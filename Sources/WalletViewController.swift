import Foundation
import UIKit
import TezosKit

public protocol WalletViewControllerDelegate: class {
  func walletViewControllerDidPressLock(_ walletViewController: WalletViewController)
}

public class WalletViewController: UIViewController {
  public weak var delegate: WalletViewControllerDelegate?

  public init(wallet: Wallet) {
    super.init(nibName: nil, bundle: nil)

    let walletView = WalletView(address: wallet.address)
    walletView.delegate = self

    self.view = walletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

extension WalletViewController: WalletViewDelegate {
  public func walletViewDidPressLock(_ walletView: WalletView) {
    self.delegate?.walletViewControllerDidPressLock(self)
  }
}
