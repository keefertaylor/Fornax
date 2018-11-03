import Foundation
import UIKit

public protocol RestoreWalletViewDelegate: class {
  func restoreWalletViewDidPressClose(_ restoreWalletView: RestoreWalletView)
  func restoreWalletViewDidPressRestoreWallet(_ restoreWalletView: RestoreWalletView)
}

public class RestoreWalletView: UIView {
  public weak var delegate: RestoreWalletViewDelegate?

  private let closeButton: UIButton
  private let restoreWalletButton: UIButton

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let restoreWalletButton = Button(frame: CGRect.zero)
    self.restoreWalletButton = restoreWalletButton

    let closeButton = Button(frame: CGRect.zero)
    self.closeButton = closeButton

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    restoreWalletButton.setTitle("Restore Wallet", for: .normal)
    restoreWalletButton.addTarget(self,
                                  action: #selector(restoreWalletButtonTapped),
                                  for: .touchUpInside)
    self.addSubview(restoreWalletButton)

    closeButton.setTitle("X", for: .normal)
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    self.addSubview(closeButton)

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
    let buttonHeight: CGFloat = 50

    // TODO: Use safe area insets here and in other classes.
    self.closeButton.sizeToFit()
    self.closeButton.widthAnchor.constraint(equalToConstant: self.closeButton.frame.size.width).isActive = true
    self.closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                               constant: -margin).isActive = true
    self.closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
    self.closeButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

    self.restoreWalletButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: margin).isActive = true
    self.restoreWalletButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                       constant: -margin).isActive = true
    self.restoreWalletButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    self.restoreWalletButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                     constant: -margin).isActive = true
  }

  @objc private func restoreWalletButtonTapped() {
    self.delegate?.restoreWalletViewDidPressRestoreWallet(self)
  }

  @objc private func closeButtonTapped() {
    self.delegate?.restoreWalletViewDidPressClose(self)
  }
}
