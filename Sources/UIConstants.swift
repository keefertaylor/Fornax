import Foundation
import UIKit

public class UIConstants {
  // Margin for all UI components.
  public static let componentMargin: CGFloat = 30

  // Preferred component height.
  public static let componentHeight: CGFloat = 50

  // Preferred border width
  public static let borderWidth: CGFloat = 3

  // Preferred border radius
  public static let borderRadius: CGFloat = 10

  // Standard colors
  public static let tezosLightBlue = UIColor(red: 44/255, green: 125/255, blue: 247/255, alpha: 1)
  public static let tezosMediumBlue = UIColor(red: 0/255, green: 85 / 255, blue: 255 / 255, alpha: 1)
  public static let tezosDarkBlue = UIColor(red: 18/255, green: 50 / 255, blue: 98 / 255, alpha: 1)

  /** Please do not instantiate this constants class. */
  @available(*, unavailable)
  private init() {}
}
