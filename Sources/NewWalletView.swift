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

  private let passphraseField: UITextField

  private let closeButton: Button
  private let submitButton: Button

  override open class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init(mnemonic: String) {
    self.mnemonicLabel = UILabel()

    self.passphraseField = UITextField()

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
    // TODO: Refactor layout constraints into a constants file
    let margin: CGFloat = 30
    let componentHeight: CGFloat = 50

    self.closeButton.sizeToFit()
    self.closeButton.widthAnchor.constraint(equalToConstant: self.closeButton.frame.size.width).isActive = true
    self.closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -margin).isActive = true
    self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                          constant: margin).isActive = true
    self.closeButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true

    self.mnemonicLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                constant: margin).isActive = true
    self.mnemonicLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -margin).isActive = true
    self.mnemonicLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor,
                                            constant: margin).isActive = true
    self.mnemonicLabel.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true

    self.passphraseField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: margin).isActive = true
    self.passphraseField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -margin).isActive = true
    self.passphraseField.topAnchor.constraint(equalTo: self.mnemonicLabel.bottomAnchor,
                                              constant: margin).isActive = true
    self.passphraseField.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true

    self.submitButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: margin).isActive = true
    self.submitButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -margin).isActive = true
    self.submitButton.topAnchor.constraint(equalTo: self.passphraseField.bottomAnchor,
                                           constant: margin).isActive = true
    self.submitButton.heightAnchor.constraint(equalToConstant: componentHeight).isActive = true
  }

  @objc private func closeButtonTapped() {
    self.delegate?.newWalletViewDidPressClose(self)
  }

  @objc private func submitButtonTapped() {
    let passphrase = self.passphraseField.text ?? ""
    self.delegate?.newWalletViewDidPressSubmit(self, passphrase: passphrase)
  }
}
