// Copyright Keefer Taylor, 2018

import Foundation
import UIKit

public class UIConstants {
  // Margin for all UI components.
  public static let componentMargin: CGFloat = 30

  // Margin between label for components
  public static let labelMargin: CGFloat = 5

  // Preferred component height.
  public static let componentHeight: CGFloat = 50

  // Preferred border width
  public static let borderWidth: CGFloat = 3

  // Preferred corner radius
  public static let cornerRadius: CGFloat = 10

  /** Please do not instantiate this constants class. */
  @available(*, unavailable)
  private init() {}
}

extension UIColor {
  // Colors for use in the app.
  public static let tezosLightBlue = UIColor(red: 44 / 255, green: 125 / 255, blue: 247 / 255, alpha: 1)
  public static let tezosDarkBlue = UIColor(red: 18 / 255, green: 50 / 255, blue: 98 / 255, alpha: 1)
  public static let accentColor = UIColor.white
}
