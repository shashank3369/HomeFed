//
//  SignupViewController.swift
//  HomeFed
//
//  Created by Shashank Kothapalli on 7/5/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignupViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
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
        GIDSignIn.sharedInstance()?.delegate = self
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
            _ = user.userID                  // For client-side use only!
            _ = user.authentication.idToken // Safe to send to the server
            _ = user.profile.name
            _ = user.profile.givenName
            _ = user.profile.familyName
            _ = user.profile.email
            // ...
        }
        
        verifyAuthIdToken(idToken: user.authentication.idToken)
    }
    
    func verifyAuthIdToken(idToken: String) {
        let signinEndpoint = "https://sleepy-hollows-17754.herokuapp.com/verify"
        let params = [
            "idtoken": idToken
        ]
        
        var request = URLRequest(url: URL(string: signinEndpoint)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            request.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Failure! \(error)")
            } else if (response as? HTTPURLResponse) != nil {
                print ("Success! \(data!)")
                let greeting = self.parseJSON(data: data!)
            } else {
                print ("Failure! \(response!)")
            }
    }
        dataTask.resume()
    }
    
    func parseJSON(data: Data) -> String {
        let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject]
        if let json = json {
            print(json)
        }
        return ""
    }
}
