import Foundation
import TezosKit
import UIKit

public protocol WalletViewDelegate: class {
  func walletViewDidPressLock(_ walletView: WalletView)
  func walletViewDidPressCopyAddress(_ walletView: WalletView)
}

public class WalletView: UIView {
  public weak var delegate: WalletViewDelegate?

  private let walletAddress: UILabel

  private let balanceLabel: UILabel
  private let currentBalanceLabel: UILabel

  private let lockWalletButton: UIButton
  private let copyAddressButton: UIButton

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

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.blue

    walletAddress.text = address
    walletAddress.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(walletAddress)

    balanceLabel.text = "Balance:"
    balanceLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(balanceLabel)

    currentBalanceLabel.text = "---"
    currentBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(currentBalanceLabel)

    lockWalletButton.setTitle("Securely Logout of Wallet", for: .normal)
    lockWalletButton.addTarget(self, action: #selector(lockWalletButtonTapped), for: .touchUpInside)
    self.addSubview(lockWalletButton)

    copyAddressButton.setTitle("Copy Wallet Address", for: .normal)
    copyAddressButton.addTarget(self, action: #selector(copyAddressButtonTapped), for: .touchUpInside)
    self.addSubview(copyAddressButton)

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
    // TODO: Refactor layout constraints into a constants file
    let margin: CGFloat = 30
    let componentHeight: CGFloat = 50

    self.walletAddress.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: margin).isActive = true
    self.walletAddress.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.walletAddress.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: margin).isActive = true
    self.walletAddress.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -margin).isActive = true

    self.balanceLabel.topAnchor.constraint(equalTo: self.walletAddress.bottomAnchor,
                                           constant: margin).isActive = true
    self.balanceLabel.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.balanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: margin).isActive = true
    self.balanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -margin).isActive = true

    self.currentBalanceLabel.topAnchor.constraint(equalTo: self.balanceLabel.bottomAnchor).isActive = true
    self.currentBalanceLabel.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.currentBalanceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: margin).isActive = true
    self.currentBalanceLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -margin).isActive = true

    self.lockWalletButton.topAnchor.constraint(equalTo: self.currentBalanceLabel.bottomAnchor,
                                               constant: margin).isActive = true
    self.lockWalletButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.lockWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: margin).isActive = true
    self.lockWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -margin).isActive = true

    self.copyAddressButton.topAnchor.constraint(equalTo: self.lockWalletButton.bottomAnchor,
                                                constant: margin).isActive = true
    self.copyAddressButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.copyAddressButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: margin).isActive = true
    self.copyAddressButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -margin).isActive = true
  }

  @objc private func lockWalletButtonTapped() {
    self.delegate?.walletViewDidPressLock(self)
  }

  @objc private func copyAddressButtonTapped() {
    self.delegate?.walletViewDidPressCopyAddress(self)
  }
}
