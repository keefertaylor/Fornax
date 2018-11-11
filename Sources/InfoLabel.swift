import Foundation
import UIKit

public class InfoLabel: UILabel {

  public var fontSize: CGFloat {
    set {
      self.font = self.font.withSize(newValue)
    }
    get {
      return self.font.pointSize
    }
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.numberOfLines = 0
    self.font = self.font.withSize(10.0)
    self.textColor = UIConstants.tezosDarkBlue
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
