import Foundation
import UIKit

public protocol InputWalletViewDelegate: class {
  func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                              mnemonic: String,
                                              passphrase: String)
}

public class InputWalletView: UIView {
  public weak var inputWalletDelegate: InputWalletViewDelegate?

  private let inputWalletButton: Button

  private let mnemonicField: TextField
  private let passphraseField: TextField

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let inputWalletButton = Button(frame: CGRect.zero)
    self.inputWalletButton = inputWalletButton

    let mnemonicField = TextField(frame: CGRect.zero)
    self.mnemonicField = mnemonicField

    let passphraseField = TextField(frame: CGRect.zero)
    self.passphraseField = passphraseField
    self.passphraseField.isSecureTextEntry = true

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    mnemonicField.placeholder = "Mnemomic"
    mnemonicField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(mnemonicField)

    passphraseField.placeholder = "Optional Passphrase"
    passphraseField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(passphraseField)

    inputWalletButton.setTitle("Input Wallet", for: .normal)
    inputWalletButton.addTarget(self,
                                  action: #selector(inputWalletButtonTapped),
                                  for: .touchUpInside)
    self.addSubview(inputWalletButton)

    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
  }

  private func applyConstraints() {
    self.mnemonicField.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.mnemonicField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: UIConstants.componentMargin).isActive = true
    self.mnemonicField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.mnemonicField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.passphraseField.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.passphraseField.topAnchor.constraint(equalTo: self.mnemonicField.bottomAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
    self.passphraseField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.passphraseField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.inputWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: UIConstants.componentMargin).isActive = true
    self.inputWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -UIConstants.componentMargin).isActive = true
    self.inputWalletButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.inputWalletButton.topAnchor.constraint(equalTo: self.passphraseField.bottomAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
  }

  @objc private func inputWalletButtonTapped() {
    let mnemonic = self.mnemonicField.text ?? ""
    let passphrase = self.passphraseField.text ?? ""
    self.inputWalletDelegate?.inputWalletViewDidPressInputWallet(self,
                                                                       mnemonic: mnemonic,
                                                                       passphrase: passphrase)
  }
}
