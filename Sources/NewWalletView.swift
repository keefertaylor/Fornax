// Copyright Keefer Taylor, 2018

import Foundation
import MnemonicKit
import UIKit

public protocol NewWalletViewDelegate: class {
  func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView,
                                   passphrase: String)
}

public class NewWalletView: UIView {
  public weak var delegate: NewWalletViewDelegate?

  public let instructionsLabel: InfoLabel
  public let mnemonicInfoLabel: InfoLabel
  public let passphraseLabel: InfoLabel

  private let mnemonicLabel: HeroLabel

  private let passphraseField: TextField

  private let submitButton: Button

  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(mnemonic: String) {
    self.instructionsLabel = InfoLabel(frame: CGRect.zero)
    instructionsLabel.text = "A wallet is made of a mnemonic and an optional passphrase. " +
      "A mnemonic has been generated for you. You can add an optional passphrase as well.\n\n" +
      "Be sure to write these down, no one can help you recover your wallet if you lose them."
    instructionsLabel.fontSize = 14

    self.mnemonicInfoLabel = InfoLabel(frame: CGRect.zero)
    mnemonicInfoLabel.text = "Your Mnemonic:"

    self.passphraseLabel = InfoLabel(frame: CGRect.zero)
    passphraseLabel.text = "Optional Passphrase:"

    self.mnemonicLabel = HeroLabel()

    self.passphraseField = TextField()

    self.submitButton = Button()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    self.addSubview(instructionsLabel)
    self.addSubview(mnemonicInfoLabel)
    self.addSubview(passphraseLabel)

    mnemonicLabel.text = mnemonic.uppercased()
    mnemonicLabel.numberOfLines = 0
    mnemonicLabel.textAlignment = .center
    self.addSubview(mnemonicLabel)

    passphraseField.placeholder = "Passphrase"
    passphraseField.isSecureTextEntry = true
    self.addSubview(passphraseField)

    submitButton.setTitle("Create Wallet", for: .normal)
    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    self.addSubview(submitButton)

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

  public override func layoutSubviews() {
    super.layoutSubviews()

    let labelWidth = self.frame.size.width - (UIConstants.componentMargin * 2)
    self.mnemonicLabel.preferredMaxLayoutWidth = labelWidth
    self.mnemonicLabel.sizeToFit()
  }

  private func applyConstraints() {
    self.instructionsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.instructionsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: UIConstants.componentMargin).isActive = true
    self.instructionsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -UIConstants.componentMargin).isActive = true

    self.mnemonicInfoLabel.topAnchor.constraint(equalTo: self.instructionsLabel.bottomAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.mnemonicInfoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: UIConstants.componentMargin).isActive = true
    self.mnemonicInfoLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -UIConstants.componentMargin).isActive = true

    self.mnemonicLabel.topAnchor.constraint(equalTo: self.mnemonicInfoLabel.bottomAnchor,
                                            constant: UIConstants.labelMargin).isActive = true
    self.mnemonicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    self.passphraseLabel.topAnchor.constraint(equalTo: self.mnemonicLabel.bottomAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
    self.passphraseLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
    self.passphraseLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -UIConstants.componentMargin).isActive = true

    self.passphraseField.topAnchor.constraint(equalTo: self.passphraseLabel.bottomAnchor,
                                              constant: UIConstants.labelMargin).isActive = true
    self.passphraseField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
    self.passphraseField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -UIConstants.componentMargin).isActive = true
    self.passphraseField.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true

    self.submitButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.submitButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true
    self.submitButton.topAnchor.constraint(equalTo: self.passphraseField.bottomAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.submitButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
  }

  @objc private func submitButtonTapped() {
    let passphrase = self.passphraseField.text ?? ""
    self.delegate?.newWalletViewDidPressSubmit(self, passphrase: passphrase)
  }
}
