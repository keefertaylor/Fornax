import Foundation
import UIKit

public protocol WelcomeViewDelegate: class {
  func welcomeViewDidPressRestoreWallet(_ welcomeView: WelcomeView)
  func welcomeViewDidPressNewWallet(_ welcomeView: WelcomeView)
}

public class WelcomeView: UIView {
  public weak var delegate: WelcomeViewDelegate?
  private let restoreWalletButton: Button
  private let newWalletButton: Button

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let restoreWalletButton = Button(frame: CGRect.zero)
    self.restoreWalletButton = restoreWalletButton

    let newWalletButton = Button(frame: CGRect.zero)
    self.newWalletButton = newWalletButton

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    restoreWalletButton.setTitle("Restore Wallet", for: .normal)
    restoreWalletButton.addTarget(self,
                                  action: #selector(restoreWalletButtonTapped),
                                  for: .touchUpInside)
    self.addSubview(restoreWalletButton)

    newWalletButton.setTitle("New Wallet", for: .normal)
    newWalletButton.addTarget(self, action: #selector(newWalletButtonTapped), for: .touchUpInside)
    self.addSubview(newWalletButton)


    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
  }

  private func applyConstraints() {
    self.newWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
    self.newWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -UIConstants.componentMargin).isActive = true
    self.newWalletButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.newWalletButton.bottomAnchor.constraint(equalTo: self.restoreWalletButton.topAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.restoreWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: UIConstants.componentMargin).isActive = true
    self.restoreWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -UIConstants.componentMargin).isActive = true
    self.restoreWalletButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.restoreWalletButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -UIConstants.componentMargin).isActive = true
  }

  @objc private func restoreWalletButtonTapped() {
    self.delegate?.welcomeViewDidPressRestoreWallet(self)
  }

  @objc private func newWalletButtonTapped() {
    self.delegate?.welcomeViewDidPressNewWallet(self)
  }
}
