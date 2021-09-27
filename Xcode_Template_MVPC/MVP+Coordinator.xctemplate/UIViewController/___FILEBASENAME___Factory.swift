//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_sceneName___ViewControllerFactory {
    func instantiate___VARIABLE_sceneName___ViewController() -> ___VARIABLE_sceneName___ViewController
}

extension DependencyProvider: ___VARIABLE_sceneName___ViewControllerFactory {
    
    func instantiate___VARIABLE_sceneName___ViewController() -> ___VARIABLE_sceneName___ViewController {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "___VARIABLE_sceneName___ViewController") as! ___VARIABLE_sceneName___ViewController
        return vc
    }

}

