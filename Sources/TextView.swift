import Foundation
import UIKit

public class TextView: UITextView {
  public init(frame: CGRect) {
    super.init(frame: frame, textContainer: nil)

    self.textColor = UIConstants.tezosLightBlue
    self.tintColor = UIConstants.tezosLightBlue
    self.layer.borderColor = UIConstants.tezosLightBlue.cgColor
    self.layer.borderWidth = UIConstants.borderWidth
    self.layer.cornerRadius = UIConstants.cornerRadius
    self.font = UIFont.systemFont(ofSize: 17)
    self.autocapitalizationType = .none
    self.textContainerInset = UIEdgeInsets(top: UIConstants.cornerRadius,
                                           left: UIConstants.cornerRadius,
                                           bottom: UIConstants.cornerRadius,
                                           right: UIConstants.cornerRadius)
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
