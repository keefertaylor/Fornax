// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public class TextView: UITextView {
  public init(frame: CGRect) {
    super.init(frame: frame, textContainer: nil)

    self.translatesAutoresizingMaskIntoConstraints = false;

    self.textColor = UIColor.tezosLightBlue
    self.tintColor = UIColor.tezosLightBlue
    self.layer.borderColor = UIColor.tezosLightBlue.cgColor
    self.layer.borderWidth = UIConstants.borderWidth
    self.layer.cornerRadius = UIConstants.cornerRadius
    self.font = UIFont.systemFont(ofSize: 17)
    self.autocapitalizationType = .none
    self.textContainerInset = UIEdgeInsets(top: UIConstants.cornerRadius,
                                           left: UIConstants.cornerRadius,
                                           bottom: UIConstants.cornerRadius,
                                           right: UIConstants.cornerRadius)
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }
}
