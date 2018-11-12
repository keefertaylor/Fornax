// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public class TextField: UITextField {
  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.textColor = UIColor.tezosLightBlue
    self.tintColor = UIColor.tezosLightBlue
    self.layer.borderColor = UIColor.tezosLightBlue.cgColor
    self.layer.borderWidth = UIConstants.borderWidth
    self.layer.cornerRadius = UIConstants.cornerRadius
  }

  public required convenience init?(coder _: NSCoder) {
    self.init(frame: CGRect.zero)
  }

  public override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: UIConstants.cornerRadius, dy: 0)
  }

  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return self.textRect(forBounds: bounds)
  }
}
