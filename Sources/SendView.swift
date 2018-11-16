// Copyright Keefer Taylor, 2018

import Foundation
import TezosKit
import UIKit

public protocol SendViewDelegate: class {
  func sendViewDidPressSend(_ sendView: SendView, amount: TezosBalance, address: String)
}

public class SendView: UIView {
  public weak var delegate: SendViewDelegate?

  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  private let addressLabel: InfoLabel
  private let addressInput: TextField

  private let amountLabel: InfoLabel
  private let amountInput: TextField

  private let sendButton: Button

  public init() {
    self.addressLabel = InfoLabel()
    self.addressInput = TextField()

    self.amountLabel = InfoLabel()
    self.amountInput = TextField()

    self.sendButton = Button()

    super.init(frame: CGRect.zero)

    self.backgroundColor = .white

    // TODO: I think I can remove autoresizing masks
    self.addressLabel.text = "Destination Address"
    self.addressLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.addressLabel)

    self.addressInput.placeholder = "Destination Address"
    self.addressInput.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.addressInput)

    self.amountLabel.text = "Amount"
    self.amountLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.amountLabel)

    self.amountInput.placeholder = "Amount"
    self.amountInput.keyboardType = .decimalPad
    self.amountInput.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.amountInput)

    self.sendButton.setTitle("SEND", for: .normal)
    self.sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    self.sendButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.sendButton)

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
    self.addressLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.addressLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.addressLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true

    self.addressInput.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor,
                                           constant: UIConstants.labelMargin).isActive = true
    self.addressInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                               constant: UIConstants.componentMargin).isActive = true
    self.addressInput.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -UIConstants.componentMargin).isActive = true
    self.addressInput.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true

    self.amountLabel.topAnchor.constraint(equalTo: self.addressInput.bottomAnchor,
                                          constant: UIConstants.componentMargin).isActive = true
    self.amountLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
    self.amountLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -UIConstants.componentMargin).isActive = true

    self.amountInput.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor,
                                          constant: UIConstants.labelMargin).isActive = true
    self.amountInput.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                              constant: UIConstants.componentMargin).isActive = true
    self.amountInput.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -UIConstants.componentMargin).isActive = true
    self.amountInput.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true

    self.sendButton.topAnchor.constraint(equalTo: self.amountInput.bottomAnchor,
                                         constant: UIConstants.componentMargin).isActive = true
    self.sendButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                             constant: UIConstants.componentMargin).isActive = true
    self.sendButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                              constant: -UIConstants.componentMargin).isActive = true
    self.sendButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
  }

  @objc private func sendButtonPressed() {
    guard let address = self.addressInput.text else {
      HUDManager.showErrorAndDismiss("Enter an address")
      return
    }

    guard let amountText = self.amountInput.text,
      let amountDecimal = Double(amountText) else {
      HUDManager.showErrorAndDismiss("Please enter a valid amount")
      return
    }
    let amount = TezosBalance(balance: amountDecimal)
    self.delegate?.sendViewDidPressSend(self, amount: amount, address: address)
  }
}
