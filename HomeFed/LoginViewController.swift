//
//  LoginViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/8/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        userNameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUp") as? SignupViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)
    }
}
