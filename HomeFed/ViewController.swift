//
//  ViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/3/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var eaterActionButton: UIButton!
    @IBOutlet weak var foodMakerActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goToFoodMakerTutorial(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Tutorial") as? TutorialPageViewController else {
            return 
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUp") as? SignupViewController else {
            return
        }
        
        present(vc, animated: true, completion: nil)
    }
}

