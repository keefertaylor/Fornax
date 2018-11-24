// Copyright Keefer Taylor, 2018

import Foundation
import TezosKit
import UIKit

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

    self.walletView = WalletView(address: self.wallet.address)

    super.init(nibName: nil, bundle: nil)

    self.walletView.delegate = self

    self.navigationItem.title = "WALLET"
    self.navigationItem.hidesBackButton = true

    let lockButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closePressed))
    self.navigationItem.leftBarButtonItem = lockButton

    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshPressed))
    let copyButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(copyPressed))
    self.navigationItem.rightBarButtonItems = [refreshButton, copyButton]

    self.view = walletView

    self.update()
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  private func update() {
    let updateDispatchGroup = DispatchGroup()

    var maybeNewBalance: TezosBalance? = nil

    HUDManager.show()
    updateDispatchGroup.enter()
    self.tezosClient.getBalance(wallet: self.wallet) { balance, error in
      guard let balance = balance,
        error == nil else {
          updateDispatchGroup.leave()
          return
      }

      maybeNewBalance = balance
      updateDispatchGroup.leave()
    }

    updateDispatchGroup.wait()

    guard let newBalance = maybeNewBalance else {
      HUDManager.showErrorAndDismiss("Error fetching balance")
      return
    }

    DispatchQueue.main.async {
      self.walletView.updateBalance(balance: newBalance)
      HUDManager.dismiss()
    }
  }

  @objc private func closePressed() {
    self.delegate?.walletViewControllerDidPressLock(self)
  }

  @objc private func copyPressed() {
    UIPasteboard.general.string = self.wallet.address
    HUDManager.showInfoAndDismiss("Address copied to clipboard.")
  }

  @objc private func refreshPressed() {
    self.update()
  }
}

extension WalletViewController: WalletViewDelegate {
  public func walletViewDidPressSend(_: WalletView) {
    let sendViewController = SendViewController(tezosClient: self.tezosClient, wallet: self.wallet)
    sendViewController.delegate = self

    let navController = UINavigationController(rootViewController: sendViewController)
    self.present(navController, animated: true)
  }
}

extension WalletViewController: SendViewControllerDelegate {
  public func sendViewControllerDidRequestClose(_ sendViewController: SendViewController) {
    DispatchQueue.main.async {
      sendViewController.dismiss(animated: true)
    }
  }
}
