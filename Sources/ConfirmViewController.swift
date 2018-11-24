import Foundation
import UIKit

public protocol ConfirmViewControllerDelegate: class {
  func confirmViewControllerDidConfirm(_ confirmViewController: ConfirmViewController)
  func confirmViewControllerDidCancel(_ confirmViewController: ConfirmViewController)
}

public class ConfirmViewController: UIViewController {
  public weak var delegate: ConfirmViewControllerDelegate?

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
    self.delegate?.confirmViewControllerDidConfirm(self)
  }

  public func confirmViewDidPressCancel(_ confirmView: ConfirmView) {
    self.delegate?.confirmViewControllerDidCancel(self)
  }
}
