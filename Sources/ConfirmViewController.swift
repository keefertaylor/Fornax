// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public class ConfirmViewController: UIViewController {
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
  public required init?(coder _: NSCoder) { fatalError() }
}

extension ConfirmViewController: ConfirmViewDelegate {
  public func confirmViewDidPressConfirm(_: ConfirmView) {
    self.confirmAction()
  }

  public func confirmViewDidPressCancel(_: ConfirmView) {
    self.cancelAction()
  }
}
