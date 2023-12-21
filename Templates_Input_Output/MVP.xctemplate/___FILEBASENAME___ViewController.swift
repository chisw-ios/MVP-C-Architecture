//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import UIKit

class ___VARIABLE_sceneName___ViewController: UIViewController {
    // MARK: - Properties
    private var presenter: ___VARIABLE_sceneName___PresenterInput!
    
    // MARK: - Subviews
    private let contentView: ___VARIABLE_sceneName___View = ___VARIABLE_sceneName___View()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Presenter
    func setPresenter(presenter: ___VARIABLE_sceneName___PresenterInput) {
        self.presenter = presenter
    }
}

// MARK: - Private
private extension ___VARIABLE_sceneName___ViewController {
   
}

// MARK: - ___VARIABLE_sceneName___ViewDelegate
extension ___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___ViewDelegate {

}

// MARK: - ___VARIABLE_sceneName___PresenterOutput
extension ___VARIABLE_sceneName___ViewController: ___VARIABLE_sceneName___PresenterOutput {
    
}
