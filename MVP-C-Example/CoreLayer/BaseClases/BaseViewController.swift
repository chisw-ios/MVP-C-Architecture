//
//  BaseViewController.swift
//  MVP-C-Example
//
//  Created by vlad.kosyi on 02.07.2021.
//

import UIKit

protocol BaseRoutesProtocol {
    var onLeftBarButton: VoidBlock { get set }
    var onRightBarButton: VoidBlock { get set }
}


struct BaseNavigationRoutes: BaseRoutesProtocol {
    var onLeftBarButton: VoidBlock
    var onRightBarButton: VoidBlock
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    var baseCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Loader.remove()
    }
    
    func setupBasicNotifications() {
       hideKeyboardWhenTappedAround()
   }
    
    func hideNavBar(_ isHidden: Bool = true) {
        self.navigationController?.navigationBar.isHidden = isHidden
    }
    
    func changeStatusBarColor(_ color: UIColor = UIColor.gray) {
        navigationController?.setStatusBar(backgroundColor: color)
    }
    
    func setupNavBar(text: String?) {
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationItem.title = text ?? ""
    }
    
    func setupBackBarButton(text: String = "", completion: @escaping ()->()) {
        let button = UIButton.backButton(with: text)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        button.addAction(for: .touchUpInside, completion)
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
    
    func primaryBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    func setupBaseCollectionView() {
        baseCollectionView.frame = view.frame
        baseCollectionView.backgroundColor = UIColor.white
        baseCollectionView.showsHorizontalScrollIndicator = false
        baseCollectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(baseCollectionView)
    }
}

