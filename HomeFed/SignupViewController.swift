//
//  SignupViewController.swift
//  HomeFed
//
//  Created by Shashank Kothapalli on 7/5/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignupViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordtextField: UITextField!
    
    @IBOutlet weak var countyTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        emailTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordtextField.borderStyle = UITextField.BorderStyle.roundedRect
        countyTextField.borderStyle = UITextField.BorderStyle.roundedRect
        confirmPasswordTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    @IBAction func signUp(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
}
