//
//  SignupViewController.swift
//  HomeFed
//
//  Created by Shashank Kothapalli on 7/5/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordtextField: UITextField!
    
    
    @IBOutlet weak var countyTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordtextField.borderStyle = UITextField.BorderStyle.roundedRect
        countyTextField.borderStyle = UITextField.BorderStyle.roundedRect
        confirmPasswordTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        
        
    }
}
