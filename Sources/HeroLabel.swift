import Foundation
import UIKit

public class HeroLabel: UILabel {
  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.numberOfLines = 0

    self.font = UIFont.boldSystemFont(ofSize: 18.0)
    self.textColor = UIConstants.tezosLightBlue
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero)
  }
}
