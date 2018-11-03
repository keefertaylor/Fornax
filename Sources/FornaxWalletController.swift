import Foundation
import UIKit

/**
 * A mediator class which will coordinate interactions between Fornax services and view controllers.
 */
public class FornaxWalletController {

  /** The root controller at the base of the hierarchy. */
  public let rootViewController: UIViewController

  public init() {
    // TODO: Wire an actual view controller here.
    self.rootViewController = UIViewController(nibName: nil, bundle: nil)
  }

  /**
   * Reset all state by clearing all sensitive data and removing all UI.
   */
  public func reset(animated: Bool) {
    self.rootViewController.dismiss(animated: animated)
  }
}
