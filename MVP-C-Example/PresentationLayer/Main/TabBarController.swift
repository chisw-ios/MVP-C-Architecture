//
//  TabBarController.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 06.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
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
