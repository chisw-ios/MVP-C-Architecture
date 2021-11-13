//
//  UINavigationBar.swift
//
import UIKit

extension UINavigationBar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }

    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}

extension UIToolbar {
    func hideBottomHairline() {
        self.hairlineImageView?.isHidden = true
    }

    func showBottomHairline() {
        self.hairlineImageView?.isHidden = false
    }
}

extension UIView {
    fileprivate var hairlineImageView: UIImageView? {
        return hairlineImageView(in: self)
    }

    fileprivate func hairlineImageView(in view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
            return imageView
        }

        for subview in view.subviews {
            if let imageView = self.hairlineImageView(in: subview) { return imageView }
        }

        return nil
    }
}
