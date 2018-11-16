import Foundation
import UIKit

public class SendView: UIView {
  open override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  public init() {
    super.init(frame: CGRect.zero)
    self.applyConstraints()
  }

  @available(*, unavailable)
  public convenience override init(frame _: CGRect) {
    fatalError()
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  private func applyConstraints() {

  }
}
