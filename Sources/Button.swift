import Foundation
import UIKit

/** A light wrapper around UIButton for UI Customizations. */
public class Button: UIButton {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false

    self.layer.cornerRadius = UIConstants.borderRadius

    self.backgroundColor = UIConstants.tezosLightBlue
    self.setTitleColor(UIConstants.accentColor, for: .normal)
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }

  public override func setTitle(_ title: String?, for state: UIControl.State) {
    let upperCasedTitle = title?.uppercased()
    super.setTitle(upperCasedTitle, for: state)
  }
}
