//
//  RoundLayerView.swift
//

import Foundation
import UIKit

 @IBDesignable open class RoundLayerView: UIView {
    
    // MARK: - Vars & Lets
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .white {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1 {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var isFullHeightCorner: Bool = false {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var isShadowEnable: Bool = false {
        didSet {
            configure()
            reloadLayout()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 20 {
        didSet {
            configure()
            reloadLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1 {
        didSet {
            configure()
            reloadLayout()
        }
    }
    
    // MARK: - Lifecycle
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = isFullHeightCorner ? bounds.height / 2 : cornerRadius
        if isShadowEnable { layer.shadowPath = UIBezierPath(rect: bounds).cgPath }
    }
    
    // MARK: - Methods
    
    private func configure() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        if isShadowEnable {
            layer.masksToBounds = false
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
            layer.shadowOffset = CGSize.zero
        }
    }
}
