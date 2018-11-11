import Foundation
import UIKit
import MnemonicKit

public protocol NewWalletViewDelegate: class {
  func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView,
                                   passphrase: String)
}

public class NewWalletView: UIView {
  public weak var delegate: NewWalletViewDelegate?

  private let mnemonicLabel: UILabel

  private let passphraseField: TextField

  private let submitButton: Button

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(mnemonic: String) {
    self.mnemonicLabel = UILabel()

    self.passphraseField = TextField()

    self.submitButton = Button()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    mnemonicLabel.text = mnemonic.uppercased()
    mnemonicLabel.translatesAutoresizingMaskIntoConstraints = false
    mnemonicLabel.numberOfLines = 0
    mnemonicLabel.textAlignment = .center
    self.addSubview(mnemonicLabel)

    passphraseField.placeholder = "Passphrase"
    passphraseField.translatesAutoresizingMaskIntoConstraints = false
    passphraseField.isSecureTextEntry = true
    self.addSubview(passphraseField)

    submitButton.setTitle("Create Wallet", for: .normal)
    submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    self.addSubview(submitButton)

    self.applyConstraints()
  }

  public override convenience init(frame: CGRect) {
    self.init()
  }

  public required convenience init(coder: NSCoder) {
    self.init()
  }

  public override func layoutSubviews() {
    super.layoutSubviews()

    let mnemonicLabelWidth = self.frame.size.width - (UIConstants.componentMargin * 2)
    self.mnemonicLabel.preferredMaxLayoutWidth = mnemonicLabelWidth
    self.mnemonicLabel.sizeToFit()
  }

  private func applyConstraints() {
    self.mnemonicLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                            constant: UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    self.passphraseField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: UIConstants.componentMargin).isActive = true
    self.passphraseField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -UIConstants.componentMargin).isActive = true
    self.passphraseField.topAnchor.constraint(equalTo: self.mnemonicLabel.bottomAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
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
