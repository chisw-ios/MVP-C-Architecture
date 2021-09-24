//
//  UIButton.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 27.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    static func backButton(with text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("<", for: .normal)
        button.sizeToFit()
        return button
    }
    
    static func barButton(with text: String? = nil, image: UIImage? = nil) -> UIButton {
        let button = UIButton(type: .system)
        if let text = text {
            button.setTitle(text, for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
        }
        if let image = image { button.setImage(image, for: .normal) }
        button.sizeToFit()
        return button
    }
    
    func handleButtonEnabling(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        let enabledColor = UIColor.white
        let disabledColor = UIColor.gray
        self.backgroundColor = isEnabled ? enabledColor : disabledColor
    }
    
    
    func handleEnablingForTextButton(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        let enabledColor = UIColor.white
        let disabledColor = UIColor.gray
        self.setTitleColor(isEnabled ? enabledColor : disabledColor, for: .normal)
    }
}

// UIButton action handler

@objc class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    // OBSERVE! can invoke itself multiple times
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
