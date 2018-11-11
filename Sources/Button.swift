import Foundation
import UIKit
import MaterialComponents

/** A light wrapper around UIButton for UI Customizations. */
public class Button: MDCButton {
  public override init(frame: CGRect) {
    super.init(frame: frame)

    MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: self)
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
