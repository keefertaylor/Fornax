import Foundation
import UIKit

public protocol ConfirmViewControllerDelegate: class {
  func confirmViewControllerDidConfirm(_ confirmViewController: ConfirmViewController)
  func confirmViewControllerDidCancel(_ confirmViewController: ConfirmViewController)
}

public class ConfirmViewController: UIViewController {
  public weak var delegate: ConfirmViewControllerDelegate?

  private let confirmView: ConfirmView

  private let confirmAction: () -> Void
  private let cancelAction: () -> Void

  public init(text: String,
              confirmAction: @escaping () -> Void,
              cancelAction: @escaping () -> Void) {
    self.confirmView = ConfirmView(text: text)
    self.confirmAction = confirmAction
    self.cancelAction = cancelAction

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
    self.confirmAction()
  }

  public func confirmViewDidPressCancel(_ confirmView: ConfirmView) {
    self.cancelAction()
  }
}
