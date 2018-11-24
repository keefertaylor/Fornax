// Copyright Keefer Taylor, 2018

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

  private func send(amount: TezosBalance, to address: String) {
    HUDManager.show()
    self.tezosClient.send(amount: amount, to: address, from: self.wallet.address, keys: self.wallet.keys) { [weak self] maybeTXHash, error in
      guard let self = self,
        let txHash = maybeTXHash,
        error == nil else {
          HUDManager.showErrorAndDismiss("Something went wrong\nTry again?")
          print("FYI, error was \(String(describing: error)) and txHash was \(String(describing: maybeTXHash))")
          return
      }
      print("FYI, TxHash was: \(txHash). See: https://tzscan.io/\(txHash)")

      HUDManager.showInfoAndDismiss("Transaction Successful.\nPlease wait a few minutes for the change to be reflected on the chain.")
      self.delegate?.sendViewControllerDidRequestClose(self)
    }
  }
}

extension SendViewController: SendViewDelegate {
  public func sendViewDidPressSend(_: SendView, amount: TezosBalance, address: String) {
    guard let navigationController = self.navigationController else {
      print("SendViewController should be inside a navigation VC.")
      return
    }

    let confirmViewControllerText =
      "You are about to send \(amount.humanReadableRepresentation) XTZ to \(address). This transaction is irreversible.\n\nAre you sure you want to proceed?"

    let confirmAction: () -> Void = { [weak self] in
      guard let self = self else {
        return
      }

      self.send(amount: amount, to: address)
    }

    let cancelAction: () -> Void = { [weak self] in
      guard let self = self else {
        return
      }
      navigationController.popToViewController(self, animated: true)
    }

    let confirmViewController = ConfirmViewController(text: confirmViewControllerText,
                                                      confirmAction: confirmAction,
                                                      cancelAction: cancelAction)
    navigationController.pushViewController(confirmViewController, animated: true)
  }
}
