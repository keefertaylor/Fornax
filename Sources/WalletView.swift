// Copyright Keefer Taylor, 2018

import Foundation
import TezosKit
import UIKit

public class WalletView: UIView {
  private let addressLabel: InfoLabel
  private let walletAddress: HeroLabel

  private let balanceLabel: InfoLabel
  private let currentBalanceLabel: HeroLabel

  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(address: String) {
    self.addressLabel = InfoLabel()
    self.walletAddress = HeroLabel()
    self.balanceLabel = InfoLabel()
    self.currentBalanceLabel = HeroLabel()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    self.addressLabel.text = "Address:"
    self.addSubview(self.addressLabel)

    self.walletAddress.text = address
    self.walletAddress.numberOfLines = 1
    self.walletAddress.adjustsFontSizeToFitWidth = true
    self.addSubview(self.walletAddress)

    self.balanceLabel.text = "Balance:"
    self.addSubview(self.balanceLabel)

    self.addSubview(self.currentBalanceLabel)

    self.applyConstraints()
  }

  public convenience override init(frame _: CGRect) {
    self.init()
  }

  public required convenience init(coder _: NSCoder) {
    self.init()
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
  }
}
