// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public protocol WelcomeViewControllerDelegate: class {
  func welcomeViewControllerDidRequestRestoreWallet(_ welcomeViewController: WelcomeViewController)
  func welcomeViewControllerDidRequestNewWallet(_ welcomeViewController: WelcomeViewController)
}

public class WelcomeViewController: UIViewController {
  public weak var delegate: WelcomeViewControllerDelegate?

  public init() {
    super.init(nibName: nil, bundle: nil)

    let welcomeView = WelcomeView(frame: CGRect.zero)
    welcomeView.delegate = self
    self.view = welcomeView
  }

  @available(*, unavailable)
  public required convenience init?(coder _: NSCoder) {
    fatalError()
  }
}

extension WelcomeViewController: WelcomeViewDelegate {
  public func welcomeViewDidPressRestoreWallet(_: WelcomeView) {
    self.delegate?.welcomeViewControllerDidRequestRestoreWallet(self)
  }

  public func welcomeViewDidPressNewWallet(_: WelcomeView) {
    self.delegate?.welcomeViewControllerDidRequestNewWallet(self)
  }
}
