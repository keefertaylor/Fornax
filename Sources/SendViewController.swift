import Foundation
import UIKit

public protocol SendViewControllerDelegate: class {
  func sendViewControllerDidRequestClose(_ sendViewController: SendViewController)
}

public class SendViewController: UIViewController {
  public weak var delegate: SendViewControllerDelegate?

  private let sendView: SendView

  public init() {
    self.sendView = SendView()

    super.init(nibName: nil, bundle: nil)

    self.navigationItem.title = "SEND"

    let closeButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonPressed))
    self.navigationItem.rightBarButtonItem = closeButton

    self.view = self.sendView
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }

  @objc private func closeButtonPressed() {
    self.delegate?.sendViewControllerDidRequestClose(self)
  }
}
