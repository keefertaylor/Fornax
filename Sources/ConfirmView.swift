import Foundation
import UIKit

public class ConfirmView: UIView {
  private let affirmativeActionButton: Button
  private let negativeActionButton: Button
  private let infoText: InfoLabel

  public init(text: String) {
    self.affirmativeActionButton = Button()
    self.negativeActionButton = Button()
    self.infoText = InfoLabel()

    super.init(frame: CGRect.zero)

    self.backgroundColor = UIColor.white

    self.infoText.fontSize = 14
    self.infoText.text = text
    self.infoText.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(infoText)

    self.affirmativeActionButton.setTitle("CONFIRM", for: .normal)
    self.affirmativeActionButton.addTarget(self, action: #selector(affirmativeActionButtonPressed), for: .touchUpInside)
    self.affirmativeActionButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.affirmativeActionButton)

    self.negativeActionButton.setTitle("CANCEL", for: .normal)
    self.negativeActionButton.addTarget(self, action: #selector(negativeActionButtonPressed), for: .touchUpInside)
    self.negativeActionButton.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(self.negativeActionButton)

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
    self.infoText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: UIConstants.componentMargin).isActive = true;
    self.infoText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                           constant: UIConstants.componentMargin).isActive = true
    self.infoText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                            constant: -UIConstants.componentMargin).isActive = true

    self.affirmativeActionButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                         constant: -UIConstants.componentMargin).isActive = true
    self.affirmativeActionButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                          constant: UIConstants.componentMargin).isActive = true
    self.affirmativeActionButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
    self.affirmativeActionButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor,
                                                           constant: -UIConstants.componentMargin / 2).isActive = true

    self.negativeActionButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                      constant: -UIConstants.componentMargin).isActive = true
    self.negativeActionButton.leadingAnchor.constraint(equalTo: self.affirmativeActionButton.trailingAnchor,
                                                          constant: UIConstants.componentMargin).isActive = true
    self.negativeActionButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                           constant: -UIConstants.componentMargin).isActive = true
    self.negativeActionButton.heightAnchor.constraint(equalToConstant: UIConstants.componentHeight).isActive = true
  }

  @objc private func affirmativeActionButtonPressed() {
  }

  @objc private func negativeActionButtonPressed() {
  }
}
