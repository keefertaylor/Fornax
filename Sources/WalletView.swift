import Foundation
import TezosKit
import UIKit

public protocol WalletViewDelegate: class {
  func walletViewDidPressLock(_ walletView: WalletView)
  func walletViewDidPressCopyAddress(_ walletView: WalletView)
  func walletViewDidPressRefreshBalance(_ walletView: WalletView)
}

public class WalletView: UIView {
  public weak var delegate: WalletViewDelegate?

  public let currentBalanceLabelPlaceholder = "---"

  private let walletAddress: UILabel

  private let balanceLabel: UILabel
  private let currentBalanceLabel: UILabel

  private let lockWalletButton: UIButton
  private let copyAddressButton: UIButton
  private let refreshBalanceButton: UIButton

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(address: String) {
    let walletAddress = UILabel()
    self.walletAddress = walletAddress

    let balanceLabel = UILabel()
    self.balanceLabel = balanceLabel

    let currentBalanceLabel = UILabel()
    self.currentBalanceLabel = currentBalanceLabel

    let lockWalletButton = Button()
    self.lockWalletButton = lockWalletButton

    let copyAddressButton = Button()
    self.copyAddressButton = copyAddressButton

    let refreshBalanceButton = Button()
    self.refreshBalanceButton = refreshBalanceButton

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.blue

    walletAddress.text = address
    walletAddress.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(walletAddress)

    balanceLabel.text = "Balance:"
    balanceLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(balanceLabel)

    currentBalanceLabel.text = self.currentBalanceLabelPlaceholder
    currentBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(currentBalanceLabel)

    lockWalletButton.setTitle("Securely Logout of Wallet", for: .normal)
    lockWalletButton.addTarget(self, action: #selector(lockWalletButtonTapped), for: .touchUpInside)
    self.addSubview(lockWalletButton)

    copyAddressButton.setTitle("Copy Wallet Address", for: .normal)
    copyAddressButton.addTarget(self, action: #selector(copyAddressButtonTapped),
                                for: .touchUpInside)
    self.addSubview(copyAddressButton)

    refreshBalanceButton.setTitle("Refresh Balance", for: .normal)
    refreshBalanceButton.addTarget(self, action: #selector(refreshBalanceButtonTapped),
                                   for: .touchUpInside)
    self.addSubview(refreshBalanceButton)

    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
  }

  public func updateBalance(balance: TezosBalance) {
    self.currentBalanceLabel.text = balance.humanReadableRepresentation
  }

  private func applyConstraints() {
    self.walletAddress.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: UIConstants.componentMargin).isActive = true
    self.walletAddress.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.walletAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.walletAddress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.balanceLabel.topAnchor.constraint(equalTo: self.walletAddress.bottomAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.balanceLabel.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.balanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.balanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true

    self.currentBalanceLabel.topAnchor.constraint(equalTo: self.balanceLabel.bottomAnchor).isActive = true
    self.currentBalanceLabel.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.currentBalanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: UIConstants.componentMargin).isActive = true
    self.currentBalanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -UIConstants.componentMargin).isActive = true

    self.lockWalletButton.topAnchor.constraint(equalTo: self.currentBalanceLabel.bottomAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.lockWalletButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.lockWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: UIConstants.componentMargin).isActive = true
    self.lockWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -UIConstants.componentMargin).isActive = true

    self.copyAddressButton.topAnchor.constraint(equalTo: self.lockWalletButton.bottomAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.copyAddressButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.copyAddressButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: UIConstants.componentMargin).isActive = true
    self.copyAddressButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -UIConstants.componentMargin).isActive = true

    self.refreshBalanceButton.topAnchor.constraint(equalTo: self.copyAddressButton.bottomAnchor,
                                                   constant: UIConstants.componentMargin).isActive = true
    self.refreshBalanceButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.refreshBalanceButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                       constant: UIConstants.componentMargin).isActive = true
    self.refreshBalanceButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -UIConstants.componentMargin).isActive = true
  }

  @objc private func lockWalletButtonTapped() {
    self.delegate?.walletViewDidPressLock(self)
  }

  @objc private func copyAddressButtonTapped() {
    self.delegate?.walletViewDidPressCopyAddress(self)
  }

  @objc private func refreshBalanceButtonTapped() {
    currentBalanceLabel.text = self.currentBalanceLabelPlaceholder
    self.delegate?.walletViewDidPressRefreshBalance(self)
  }
}
