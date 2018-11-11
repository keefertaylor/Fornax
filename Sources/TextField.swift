import Foundation
import MaterialComponents

public class TextField: MDCTextField {
  private var controller: MDCTextInputControllerOutlined?;

  public override init(frame: CGRect) {
    super.init(frame: frame)

    self.controller = MDCTextInputControllerOutlined(textInput: self)
  }

  // TODO: Straighten out story with encoding / decoding and nibs.
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
