import Foundation
import UIKit

/** A light wrapper around UIButton for UI Customizations. */
public class Button: UIButton {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
