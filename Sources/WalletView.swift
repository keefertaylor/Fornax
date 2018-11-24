// Copyright Keefer Taylor, 2018

import Foundation
import TezosKit
import UIKit

public protocol WalletViewDelegate: class {
  func walletViewDidPressSend(_ walletView: WalletView)
}

public class WalletView: UIView {
  public weak var delegate: WalletViewDelegate?

  private let addressLabel: InfoLabel
  private let walletAddress: HeroLabel

  private let balanceLabel: InfoLabel
  private let currentBalanceLabel: HeroLabel

  private let delegateLabel: InfoLabel
  private let currentDelegateLabel: HeroLabel

  private let sendButton: Button

  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(address: String) {
    self.addressLabel = InfoLabel()
    self.walletAddress = HeroLabel()
    self.balanceLabel = InfoLabel()
    self.currentBalanceLabel = HeroLabel()
    self.delegateLabel = InfoLabel()
    self.currentDelegateLabel = HeroLabel()
    self.sendButton = Button()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    self.sendButton.setTitle("SEND", for: .normal)
    self.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    self.addSubview(self.sendButton)

    self.addressLabel.text = "Address:"
    self.addSubview(self.addressLabel)

    self.walletAddress.text = address
    self.walletAddress.numberOfLines = 1
    self.walletAddress.adjustsFontSizeToFitWidth = true
    self.addSubview(self.walletAddress)

    self.balanceLabel.text = "Balance:"
    self.addSubview(self.balanceLabel)

    self.addSubview(self.currentBalanceLabel)

    self.delegateLabel.text = "Delegate:"
    self.addSubview(self.delegateLabel)

    self.addSubview(self.currentDelegateLabel)

    self.applyConstraints()
  }

  @available(*, unavailable)
  public required convenience override init(frame _: CGRect) {
    fatalError()
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  public func updateBalance(balance: TezosBalance) {
    self.currentBalanceLabel.text = balance.humanReadableRepresentation + " XTZ"
  }

  private func applyConstraints() {
    self.addressLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.addressLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.addressLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true

    self.walletAddress.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor,
                                            constant: UIConstants.labelMargin).isActive = true
    self.walletAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.walletAddress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.balanceLabel.topAnchor.constraint(equalTo: self.walletAddress.bottomAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.balanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.balanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true

    self.currentBalanceLabel.topAnchor.constraint(equalTo: self.balanceLabel.bottomAnchor,
                                                  constant: UIConstants.labelMargin).isActive = true
    self.currentBalanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: UIConstants.componentMargin).isActive = true
    self.currentBalanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -UIConstants.componentMargin).isActive = true

    self.delegateLabel.topAnchor.constraint(equalTo: self.currentBalanceLabel.bottomAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.delegateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.delegateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true

    self.currentDelegateLabel.topAnchor.constraint(equalTo: self.delegateLabel.bottomAnchor,
                                                  constant: UIConstants.labelMargin).isActive = true
    self.currentDelegateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: UIConstants.componentMargin).isActive = true
    self.currentDelegateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -UIConstants.componentMargin).isActive = true

    self.sendButton.topAnchor.constraint(equalTo: self.currentDelegateLabel.bottomAnchor,
                                         constant: UIConstants.componentMargin).isActive = true
    self.sendButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                             constant: UIConstants.componentMargin).isActive = true
    self.sendButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                              constant: -UIConstants.componentMargin).isActive = true
    self.sendButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
  }

  @objc private func sendButtonPressed() {
    self.delegate?.walletViewDidPressSend(self)
  }
}
