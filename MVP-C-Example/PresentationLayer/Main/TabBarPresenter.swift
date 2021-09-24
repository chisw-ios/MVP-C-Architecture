//
//  TabBarPresenter.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 12.11.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation

struct TabBarRoutes {
    var onLeftButton: VoidBlock
    var onRightButton: VoidBlock
    var onError: ((ErrorMessage) -> Void)?
}

protocol TabBarPresenterProtocol {
    func onLeftButton()
    func onRightButton()
}

class TabBarPresenter: NSObject, TabBarPresenterProtocol {
    
    private var routes: TabBarRoutes
    
    //MARK: LifeCycle
        //MARK: LifeCycle
    init(routes: TabBarRoutes) {
        self.routes = routes

    }
    
    func onLeftButton() {
        routes.onLeftButton?()
    }

    func onRightButton() {
        routes.onRightButton?()
    }
}
