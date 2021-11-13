//
//  UIViewController.swift
//

import UIKit

// MARK: - hideKeyboardWhenTappedAround

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - hideVCWhenTappedAround
extension UIViewController {
    func hideVCWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmisVC))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmisVC() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - childVC
@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeChilds() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

