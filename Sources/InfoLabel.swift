// Copyright Keefer Taylor, 2018

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
    self.textColor = UIColor.tezosDarkBlue
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  public required convenience init?(coder _: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
