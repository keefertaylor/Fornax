import Foundation
import SVProgressHUD

public class HUDManager {
  public static func show() {
    SVProgressHUD.show()
  }

  public static func showInfoAndDismiss(_ info: String) {
    SVProgressHUD.showInfo(withStatus: info)
  }

  public static func showErrorAndDismiss(_ error: String) {
    SVProgressHUD.showError(withStatus: error)
  }

  public static func dismiss() {
    SVProgressHUD.dismiss()
  }

  /** Please do not instantiate this static utility class. */
  @available(*, unavailable)
  private init() {}
}
