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

    let welcomeView = WelcomeView()
    welcomeView.delegate = self
    self.view = welcomeView
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }

  public override var prefersStatusBarHidden: Bool {
    return true
  }
}

extension WelcomeViewController: WelcomeViewDelegate {
  public func welcomeViewDidPressRestoreWallet(_ welcomeView: WelcomeView) {
    self.delegate?.welcomeViewControllerDidRequestRestoreWallet(self)
  }

  public func welcomeViewDidPressNewWallet(_ welcomeView: WelcomeView) {
    self.delegate?.welcomeViewControllerDidRequestNewWallet(self)
  }
}
