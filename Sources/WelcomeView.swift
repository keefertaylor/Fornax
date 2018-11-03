import Foundation
import UIKit

public protocol WelcomeViewDelegate: class {
  func welcomeViewDidPressRestoreWallet(_ welcomeView: WelcomeView)
}

public class WelcomeView: UIView {
  public weak var delegate: WelcomeViewDelegate?
  private let restoreWalletButton: UIButton

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let restoreWalletButton = Button(frame: CGRect.zero)
    self.restoreWalletButton = restoreWalletButton

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    restoreWalletButton.setTitle("Restore Wallet", for: .normal)
    restoreWalletButton.addTarget(self,
                                  action: #selector(restoreWalletButtonTapped),
                                  for: .touchUpInside)
    self.addSubview(restoreWalletButton)

    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
  }

  private func applyConstraints() {
    let margin: CGFloat = 30
    let buttonHeight: CGFloat = 50

    self.restoreWalletButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: margin).isActive = true
    self.restoreWalletButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                       constant: -margin).isActive = true
    self.restoreWalletButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    self.restoreWalletButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                     constant: -margin).isActive = true
  }

  @objc private func restoreWalletButtonTapped() {
    self.delegate?.welcomeViewDidPressRestoreWallet(self)
  }
}
