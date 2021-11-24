//
//  UIView.swift
//

import Foundation
import UIKit

extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
    func loadViewFromNib() {
      let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
      let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)

      let views = ["view": view]
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
      setNeedsUpdateConstraints()
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    public func reloadLayout() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

protocol ViewDesignable : class {}

extension ViewDesignable where Self : UIView {
    
    static func nibInit() -> Self {
        
        let className = String(describing: self)
        return UINib(nibName: className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Self
    }
}

extension UIView : ViewDesignable {}

extension NSLayoutConstraint {
    
    func animate(value: CGFloat, duration: TimeInterval, completion: VoidBlock) {
          UIView.animate(withDuration: duration, animations: {
            self.constant = value
            completion?()
          })
      }
}

extension UIView {
    func fitSizeOfContent() -> CGSize {
        let sumHeight = self.subviews.map({$0.frame.size.height}).reduce(.zero, {x, y in x + y})
         return CGSize(width: self.frame.width, height: sumHeight)
    }
}
