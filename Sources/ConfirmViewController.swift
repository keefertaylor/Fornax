import Foundation
import UIKit

public class ConfirmViewController: UIViewController {
  private let confirmView: ConfirmView

  public init() {
    self.confirmView = ConfirmView(text: "Placeholder text")

    super.init(nibName: nil, bundle: nil)

    self.navigationItem.title = "CONFIRM"

    self.confirmView.delegate = self

    self.view = self.confirmView
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) { fatalError() }
}

extension ConfirmViewController: ConfirmViewDelegate {
  public func confirmViewDidPressConfirm(_ confirmView: ConfirmView) {
    // TODO: Implement.
  }

  public func confirmViewDidPressCancel(_ confirmView: ConfirmView) {
    // TODO: Implement.
  }
}
