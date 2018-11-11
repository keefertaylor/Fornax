import Foundation
import UIKit

public class TextView: UITextView {
  public init(frame: CGRect) {
    super.init(frame: frame, textContainer: nil)

    self.textColor = UIConstants.tezosLightBlue
    self.tintColor = UIConstants.tezosLightBlue
    self.layer.borderColor = UIConstants.tezosLightBlue.cgColor
    self.layer.borderWidth = UIConstants.borderWidth
    self.layer.cornerRadius = UIConstants.borderRadius
    self.font = UIFont.systemFont(ofSize: 17)
    self.autocapitalizationType = .none
    self.textContainerInset = UIEdgeInsets(top: UIConstants.borderRadius,
                                           left: UIConstants.borderRadius,
                                           bottom: UIConstants.borderRadius,
                                           right: UIConstants.borderRadius)
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
