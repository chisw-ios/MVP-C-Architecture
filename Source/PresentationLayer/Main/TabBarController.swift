//
//  TabBarController.swift
//

import UIKit

class TabBarController: UITabBarController {
    
    var presenter: TabBarPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupLeftBarButton(text: String? = nil, image: UIImage? = nil, completion: @escaping ()->()) {
        let button = UIButton.barButton(with: text, image: image)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.addAction(for: .touchUpInside, completion)
    }
    
    func setupRightBarButton(text: String? = nil, image: UIImage? = nil, completion: @escaping ()->()) {
        let button = UIButton.barButton(with: text, image: image)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addAction(for: .touchUpInside, completion)
    }
}
