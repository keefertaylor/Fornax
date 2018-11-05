import Foundation
import UIKit

public class WalletView: UIView {
  private let walletAddress: UILabel
  private let lockWalletButton: UIButton

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(address: String) {
    let walletAddress = UILabel()
    self.walletAddress = walletAddress

    let lockWalletButton = Button()
    self.lockWalletButton = lockWalletButton

    super.init(frame: CGRect.zero)

    walletAddress.text = address
    walletAddress.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(walletAddress)

    lockWalletButton.setTitle("Securely Logout of Wallet", for: .normal)
    lockWalletButton.addTarget(self, action: #selector(lockWalletButtonTapped), for: .touchUpInside)
    self.addSubview(lockWalletButton)

    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
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


    self.lockWalletButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -margin).isActive = true
    self.lockWalletButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.lockWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                   constant: margin).isActive = true
    self.lockWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -margin).isActive = true
  }

  @objc private func lockWalletButtonTapped() {
    // TODO: Wire up a delegate.
  }
}
