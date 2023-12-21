//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import UIKit

protocol ___VARIABLE_sceneName___ViewDelegate: AnyObject {
    
}

class ___VARIABLE_sceneName___View: UIView {
    // MARK: - Properties
    private weak var delegate: ___VARIABLE_sceneName___ViewDelegate?
    
    // MARK: - Subviews
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    // MARK: - Delegate
    func setDelegate( delegate: ___VARIABLE_sceneName___ViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Private
private extension ___VARIABLE_sceneName___View {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupUI() {
        
    }
    
    func setupLayout() {
        
    }
}
