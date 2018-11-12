// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public class HeroLabel: UILabel {
  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.numberOfLines = 0

    self.font = UIFont.boldSystemFont(ofSize: 18.0)
    self.textColor = UIColor.tezosLightBlue
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }
}
