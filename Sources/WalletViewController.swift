import Foundation
import UIKit
import SVProgressHUD
import TezosKit

public protocol WalletViewControllerDelegate: class {
  func walletViewControllerDidPressLock(_ walletViewController: WalletViewController)
}

public class WalletViewController: UIViewController {
  public weak var delegate: WalletViewControllerDelegate?

  private let wallet: Wallet
  private let tezosClient: TezosClient

  private let walletView: WalletView

  public init(wallet: Wallet, tezosClient: TezosClient) {
    self.wallet = wallet
    self.tezosClient = tezosClient

    let walletView = WalletView(address: wallet.address)
    self.walletView = walletView

    super.init(nibName: nil, bundle: nil)

    walletView.delegate = self
    self.view = walletView

    self.updateBalance()
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func updateBalance() {
    // TODO: Check retain cycles.
    self.tezosClient.getBalance(wallet: self.wallet) { balance, error in
      guard let balance = balance,
        error == nil else {
          SVProgressHUD.showError(withStatus: "Error fetching balance")
          return
      }

      DispatchQueue.main.async {
        self.walletView.updateBalance(balance: balance)
      }
    }
  }
}

extension WalletViewController: WalletViewDelegate {
  public func walletViewDidPressLock(_ walletView: WalletView) {
    self.delegate?.walletViewControllerDidPressLock(self)
  }

  public func walletViewDidPressCopyAddress(_ walletView: WalletView) {
    UIPasteboard.general.string = self.wallet.address
    SVProgressHUD.showInfo(withStatus: "Address copied to clipboard.")
  }

  public func walletViewDidPressRefreshBalance(_ walletView: WalletView) {
    self.updateBalance()
  }
}
