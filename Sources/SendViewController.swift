import Foundation
import TezosKit
import UIKit

public protocol SendViewControllerDelegate: class {
  func sendViewControllerDidRequestClose(_ sendViewController: SendViewController)
}

public class SendViewController: UIViewController {
  public weak var delegate: SendViewControllerDelegate?

  private let sendView: SendView
  private let tezosClient: TezosClient
  private let wallet: Wallet

  public init(tezosClient: TezosClient, wallet: Wallet) {
    self.sendView = SendView()
    self.tezosClient = tezosClient
    self.wallet = wallet

    super.init(nibName: nil, bundle: nil)

    sendView.delegate = self

    self.navigationItem.title = "SEND"

    let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonPressed))
    self.navigationItem.rightBarButtonItem = closeButton

    self.view = self.sendView
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  @objc private func closeButtonPressed() {
    self.delegate?.sendViewControllerDidRequestClose(self)
  }
}

extension SendViewController: SendViewDelegate {
  public func sendViewDidPressSend(_ sendView: SendView, amount: TezosBalance, address: String) {
    // TODO: Add a confirm view and prompt user to affirm their choices.
    HUDManager.show()
    self.tezosClient.send(amount: amount, to: address, from: self.wallet.address, keys: self.wallet.keys) { [weak self] txHash, error  in
      guard let self = self,
            let txHash = txHash,
            error == nil else {
        HUDManager.showErrorAndDismiss("Something went wrong\nTry again?")
        return
      }
      print("FYI, TxHash was: \(txHash). See: https://tzscan.io/\(txHash)")

      HUDManager.showInfoAndDismiss("Transaction Successful.\nPlease wait a few minutes for the change to be reflected on the chain.")
      self.delegate?.sendViewControllerDidRequestClose(self)
    }
  }
}
