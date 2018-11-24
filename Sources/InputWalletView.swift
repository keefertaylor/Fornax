// Copyright Keefer Taylor, 2018

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

  private let instructionsLabel: InfoLabel
  private let mnemonicLabel: InfoLabel
  private let passphraseLabel: InfoLabel

  private let mnemonicField: TextView
  private let passphraseField: TextField

  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(instructions: String) {
    self.instructionsLabel = InfoLabel()
    self.instructionsLabel.fontSize = 14
    self.instructionsLabel.text = instructions

    self.mnemonicLabel = InfoLabel()
    self.mnemonicLabel.text = "Mnemonic:"

    self.passphraseLabel = InfoLabel()
    self.passphraseLabel.text = "Optional Passphrase:"

    self.inputWalletButton = Button(frame: CGRect.zero)

    self.mnemonicField = TextView(frame: CGRect.zero)

    self.passphraseField = TextField(frame: CGRect.zero)
    self.passphraseField.isSecureTextEntry = true

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    self.addSubview(mnemonicLabel)
    self.addSubview(passphraseLabel)

    self.addSubview(mnemonicField)

    passphraseField.placeholder = "Optional Passphrase"
    self.addSubview(passphraseField)

    inputWalletButton.setTitle("Input Wallet", for: .normal)
    inputWalletButton.addTarget(self,
                                action: #selector(inputWalletButtonTapped),
                                for: .touchUpInside)
    self.addSubview(inputWalletButton)

    self.addSubview(instructionsLabel)

    self.applyConstraints()
  }

  @available(*, unavailable)
  public convenience override init(frame _: CGRect) {
    fatalError()
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  private func applyConstraints() {
    self.instructionsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.instructionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: UIConstants.componentMargin).isActive = true
    self.instructionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -UIConstants.componentMargin).isActive = true

    self.mnemonicLabel.topAnchor.constraint(equalTo: self.instructionsLabel.bottomAnchor,
                                            constant: UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.mnemonicField.heightAnchor.constraint(equalToConstant: 100).isActive = true
    self.mnemonicField.topAnchor.constraint(equalTo: self.mnemonicLabel.bottomAnchor,
                                            constant: UIConstants.labelMargin).isActive = true
    self.mnemonicField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.mnemonicField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true

    self.passphraseLabel.topAnchor.constraint(equalTo: self.mnemonicField.bottomAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
    self.passphraseLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
    self.passphraseLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -UIConstants.componentMargin).isActive = true

    self.passphraseField.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.passphraseField.topAnchor.constraint(equalTo: self.passphraseLabel.bottomAnchor,
                                              constant: UIConstants.labelMargin).isActive = true
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
