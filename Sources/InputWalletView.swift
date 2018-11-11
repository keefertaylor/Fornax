import Foundation
import UIKit

public protocol InputWalletViewDelegate: class {
  func inputWalletViewDidPressClose(_ inputWalletView: InputWalletView)
  func inputWalletViewDidPressInputWallet(_ inputWalletView: InputWalletView,
                                              mnemonic: String,
                                              passphrase: String)
}

public class InputWalletView: UIScrollView {
  public weak var inputWalletDelegate: InputWalletViewDelegate?

  private let closeButton: Button
  private let inputWalletButton: Button

  private let mnemonicField: TextField
  private let passphraseField: TextField

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    let inputWalletButton = Button(frame: CGRect.zero)
    self.inputWalletButton = inputWalletButton

    let closeButton = Button(frame: CGRect.zero)
    self.closeButton = closeButton

    let mnemonicField = TextField(frame: CGRect.zero)
    self.mnemonicField = mnemonicField

    let passphraseField = TextField(frame: CGRect.zero)
    self.passphraseField = passphraseField

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    mnemonicField.placeholder = "Mnemomic"
    mnemonicField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(mnemonicField)

    passphraseField.placeholder = "Passphrase"
    passphraseField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(passphraseField)

    inputWalletButton.setTitle("Input Wallet", for: .normal)
    inputWalletButton.addTarget(self,
                                  action: #selector(inputWalletButtonTapped),
                                  for: .touchUpInside)
    self.addSubview(inputWalletButton)

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

    self.inputWalletButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: margin).isActive = true
    self.inputWalletButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -margin).isActive = true
    self.inputWalletButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
    self.inputWalletButton.topAnchor.constraint(equalTo: self.passphraseField.bottomAnchor,
                                                  constant: margin).isActive = true
  }

  @objc private func inputWalletButtonTapped() {
    let mnemonic = self.mnemonicField.text ?? ""
    let passphrase = self.passphraseField.text ?? ""
    self.inputWalletDelegate?.inputWalletViewDidPressInputWallet(self,
                                                                       mnemonic: mnemonic,
                                                                       passphrase: passphrase)
  }

  @objc private func closeButtonTapped() {
    self.inputWalletDelegate?.inputWalletViewDidPressClose(self)
  }
}
