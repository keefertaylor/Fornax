import Foundation
import UIKit
import MnemonicKit

public protocol NewWalletViewDelegate: class {
  func newWalletViewDidPressSubmit(_ newWalletView: NewWalletView,
                                   passphrase: String)
  func newWalletViewDidPressClose(_ newWalletView: NewWalletView)
}

public class NewWalletView: UIView {
  public weak var delegate: NewWalletViewDelegate?

  private let mnemonicLabel: UILabel

  private let passphraseField: TextField

  private let closeButton: Button
  private let submitButton: Button

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(mnemonic: String) {
    self.mnemonicLabel = UILabel()

    self.passphraseField = TextField()

    self.closeButton = Button()
    self.submitButton = Button()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    mnemonicLabel.text = mnemonic
    mnemonicLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(mnemonicLabel)

    passphraseField.placeholder = "Passphrase"
    passphraseField.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(passphraseField)

    closeButton.setTitle("X", for: .normal)
    closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    self.addSubview(closeButton)

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

  private func applyConstraints() {
    self.closeButton.sizeToFit()
    self.closeButton.widthAnchor.constraint(equalToConstant: self.closeButton.frame.size.width).isActive = true
    self.closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -UIConstants.componentMargin).isActive = true
    self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                          constant: UIConstants.componentMargin).isActive = true
    self.closeButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true

    self.mnemonicLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor,
                                            constant: UIConstants.componentMargin).isActive = true
    self.mnemonicLabel.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true

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

  @objc private func closeButtonTapped() {
    self.delegate?.newWalletViewDidPressClose(self)
  }

  @objc private func submitButtonTapped() {
    let passphrase = self.passphraseField.text ?? ""
    self.delegate?.newWalletViewDidPressSubmit(self, passphrase: passphrase)
  }
}
