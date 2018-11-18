import Foundation
import UIKit

public class ConfirmViewController: UIViewController {
  private let confirmView: ConfirmView

  public init() {
    self.confirmView = ConfirmView(text: "Placeholder text")

    super.init(nibName: nil, bundle: nil)

    self.navigationItem.title = "CONFIRM"

    self.view = self.confirmView
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) { fatalError() }
}
