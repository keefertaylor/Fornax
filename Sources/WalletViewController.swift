import Foundation
import UIKit
import SVProgressHUD
import TezosKit

public protocol WalletViewControllerDelegate: class {
  func walletViewControllerDidPressLock(_ walletViewController: WalletViewController)
}

public class WalletViewController: UIViewController {
  public weak var delegate: WalletViewControllerDelegate?

  public init(wallet: Wallet, tezosClient: TezosClient) {
    super.init(nibName: nil, bundle: nil)

    let walletView = WalletView(address: wallet.address)
    walletView.delegate = self

    // TODO: How do retain cycles work in swift again?
    tezosClient.getBalance(address: wallet.address) { (balance, error) in
      guard let balance = balance,
        error == nil else {
          SVProgressHUD.showError(withStatus: "Error fetching balance")
          return
      }

      DispatchQueue.main.async {
        walletView.updateBalance(balance: balance)
      }
    }

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
