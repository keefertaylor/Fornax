import Foundation
import UIKit

public class FornaxLogo: UIView {
  private let titleLabel: UILabel
  private let subtitleLabel: UILabel
  private let authorLabel: UILabel

  private let boxView: UIView

  public override init(frame: CGRect) {
    self.titleLabel = UILabel()
    self.subtitleLabel = UILabel()
    self.authorLabel = UILabel()
    self.boxView = UIView()

    super.init(frame: frame)

    self.translatesAutoresizingMaskIntoConstraints = false

    self.boxView.clipsToBounds = true
    self.boxView.layer.borderWidth = UIConstants.borderWidth
    self.boxView.layer.borderColor = UIColor.tezosDarkBlue.cgColor
    self.boxView.layer.cornerRadius = UIConstants.cornerRadius
    self.boxView.translatesAutoresizingMaskIntoConstraints = false

    self.titleLabel.text = "FORNAX"
    self.titleLabel.textAlignment = .center
    self.titleLabel.font = self.titleLabel.font.withSize(24)
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel.backgroundColor = UIColor.tezosDarkBlue
    self.titleLabel.textColor = UIColor.accentColor

    self.subtitleLabel.text = "An Open Source\nWallet for Tezos"
    self.subtitleLabel.numberOfLines = 0
    self.subtitleLabel.font = self.subtitleLabel.font.withSize(14)
    self.subtitleLabel.textAlignment = .center
    self.subtitleLabel.textColor = UIColor.tezosDarkBlue
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

    self.authorLabel.text = "By Keefer Taylor"
    self.authorLabel.font = self.subtitleLabel.font.withSize(10)
    self.authorLabel.textAlignment = .right
    self.authorLabel.textColor = UIColor.gray.withAlphaComponent(0.5)
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = false

    self.boxView.addSubview(self.titleLabel)
    self.boxView.addSubview(self.subtitleLabel)

    self.addSubview(self.boxView)
    self.addSubview(self.authorLabel)

    self.applyContraints()
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }

  private func applyContraints() {
    self.titleLabel.sizeToFit()
    self.subtitleLabel.sizeToFit()

    self.titleLabel.topAnchor.constraint(equalTo: self.boxView.topAnchor).isActive = true
    self.titleLabel.leadingAnchor.constraint(equalTo: self.boxView.leadingAnchor).isActive = true
    self.titleLabel.trailingAnchor.constraint(equalTo: self.boxView.trailingAnchor).isActive = true
    self.titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true

    self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                            constant: UIConstants.labelMargin).isActive = true
    self.subtitleLabel.leadingAnchor.constraint(equalTo: self.boxView.leadingAnchor).isActive = true
    self.subtitleLabel.trailingAnchor.constraint(equalTo: self.boxView.trailingAnchor).isActive = true

    self.boxView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
    self.boxView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    self.boxView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
    self.boxView.heightAnchor.constraint(equalToConstant: 130).isActive = true

    self.authorLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
    self.authorLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    self.authorLabel.topAnchor.constraint(equalTo: self.boxView.bottomAnchor,
                                          constant: UIConstants.labelMargin).isActive = true
  }
}
