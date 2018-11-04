import Foundation
import UIKit

public protocol RestoreWalletViewDelegate: class {
  func restoreWalletViewDidPressClose(_ restoreWalletView: RestoreWalletView)
  func restoreWalletViewDidPressRestoreWallet(_ restoreWalletView: RestoreWalletView,
                                              mnemonic: String,
                                              passphrase: String)
}

public class RestoreWalletView: UIScrollView {
  public weak var restoreWalletDelegate: RestoreWalletViewDelegate?

  private let closeButton: UIButton
  private let restoreWalletButton: UIButton

  private let mnemonicField: UITextField
  private let passphraseField: UITextField

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let restoreWalletButton = Button(frame: CGRect.zero)
    self.restoreWalletButton = restoreWalletButton

    let closeButton = Button(frame: CGRect.zero)
    self.closeButton = closeButton

    let mnemonicField = UITextField(frame: CGRect.zero)
    self.mnemonicField = mnemonicField

    let passphraseField = UITextField(frame: CGRect.zero)
    self.passphraseField = passphraseField

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    mnemonicField.placeholder = "Mnemomic"
    mnemonicField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(mnemonicField)

    passphraseField.placeholder = "Passphrase"
    passphraseField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(passphraseField)

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
    let componentHeight: CGFloat = 50

    // TODO: Use safe area insets here and in other classes.
    self.closeButton.sizeToFit()
    self.closeButton.widthAnchor.constraint(equalToConstant: self.closeButton.frame.size.width).isActive = true
    self.closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -margin).isActive = true
    self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                          constant: margin).isActive = true
    self.closeButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true

    self.mnemonicField.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.mnemonicField.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor,
                                            constant: margin).isActive = true
    self.mnemonicField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: margin).isActive = true
    self.mnemonicField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -margin).isActive = true

    self.passphraseField.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.passphraseField.topAnchor.constraint(equalTo: self.mnemonicField.bottomAnchor,
                                              constant: margin).isActive = true
    self.passphraseField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: margin).isActive = true
    self.passphraseField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -margin).isActive = true

    self.restoreWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: margin).isActive = true
    self.restoreWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -margin).isActive = true
    self.restoreWalletButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.restoreWalletButton.topAnchor.constraint(equalTo: self.passphraseField.bottomAnchor,
                                                  constant: margin).isActive = true
  }

  @objc private func restoreWalletButtonTapped() {
    let mnemonic = self.mnemonicField.text ?? ""
    let passphrase = self.passphraseField.text ?? ""
    self.restoreWalletDelegate?.restoreWalletViewDidPressRestoreWallet(self,
                                                                       mnemonic: mnemonic,
                                                                       passphrase: passphrase)
  }

  @objc private func closeButtonTapped() {
    self.restoreWalletDelegate?.restoreWalletViewDidPressClose(self)
  }
}
