import Foundation
import UIKit
import TezosKit

public class WalletViewController: UIViewController {
  public init(wallet: Wallet) {
    super.init(nibName: nil, bundle: nil)

    let walletView = WalletView(address: wallet.address)
    self.view = walletView
  }

  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}

