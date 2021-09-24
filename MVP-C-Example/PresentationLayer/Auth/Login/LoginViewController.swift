//
//  LoginViewController.swift
//  PharmacyPortal
//
//  Created by vlad.kosyi on 20.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let numberOfLinesInButtonTitle = 1
    }
    
    // MARK: - Vars & Lets

    @IBOutlet weak var entranceButton: UIButton!
    var viewModel: LoginPresenterProtocol?
    var biometricService = BiometricsManager()

    // MARK: - Controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTexts()
    }

    
    // MARK: - Actions
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        self.viewModel?.enter()
    }

    func setupTexts() {
        entranceButton.setTitle(L10n.LoginViewController.EntranceButton.title, for: .normal)
    }
}
