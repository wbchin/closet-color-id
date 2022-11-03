//
//  AnyGestureRecognizer.swift
//  closet-color-id
//
//  Created by Allison Cao on 11/3/22.
//

import Foundation
import UIKit

class AnyGestureRecognizer: UIGestureRecognizer {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    //To prevent keyboard hide and show when switching from one textfield to another
    if let textField = touches.first?.view, textField is UITextField {
      state = .failed
    } else {
      state = .began
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    state = .ended
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
    state = .cancelled
  }
}
