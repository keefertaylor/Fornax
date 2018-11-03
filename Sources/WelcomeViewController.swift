import Foundation
import UIKit

public class WelcomeViewController: UIViewController {
  public init() {
    super.init(nibName: nil, bundle: nil)

    let welcomeView = WelcomeView()
    self.view = welcomeView
  }

  public required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
}
