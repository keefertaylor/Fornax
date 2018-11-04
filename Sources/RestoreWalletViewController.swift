import Foundation
import UIKit

public protocol RestoreWalletViewControllerDelegate: class {
  func restoreWalletViewControllerDidRequestRestoreWallet(_ restoreWalletViewController: RestoreWalletViewController)
  func restoreWalletViewControllerDidRequestClose(_ restoreWalletViewController: RestoreWalletViewController)
}

public class RestoreWalletViewController: UIViewController {
  public weak var delegate: RestoreWalletViewControllerDelegate?

  public init() {
    super.init(nibName: nil, bundle: nil)

    let restoreWalletView = RestoreWalletView()
    restoreWalletView.restoreWalletDelegate = self
    self.view = restoreWalletView
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}

extension RestoreWalletViewController: RestoreWalletViewDelegate {
  public func restoreWalletViewDidPressClose(_ restoreWalletView: RestoreWalletView) {
    self.delegate?.restoreWalletViewControllerDidRequestClose(self)
  }

  public func restoreWalletViewDidPressRestoreWallet(_ restoreWalletView: RestoreWalletView) {
    self.delegate?.restoreWalletViewControllerDidRequestRestoreWallet(self)
  }
}
