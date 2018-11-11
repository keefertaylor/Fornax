import Foundation
import UIKit

public class TextField: UITextField {
  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.textColor = UIConstants.tezosLightBlue
    self.tintColor = UIConstants.tezosLightBlue
    self.layer.borderColor = UIConstants.tezosLightBlue.cgColor
    self.layer.borderWidth = UIConstants.borderWidth
    self.layer.cornerRadius = UIConstants.cornerRadius
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }

  public override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: UIConstants.cornerRadius, dy: 0)
  }

  public override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return self.textRect(forBounds: bounds)
  }
}
