//
//  RestConsumerViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/19/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class RestConsumerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGreeting()
    }
    
    @IBOutlet weak var greetingLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchGreeting() {
        var url = URL(string: "https://sleepy-hollows-17754.herokuapp.com/greeting?name=Shashank")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!, completionHandler:  { (data, response, error) in
            if let error = error {
                print("Failure! \(error)")
            } else if (response as? HTTPURLResponse) != nil {
                print ("Success! \(data!)")
                let greeting = self.parseJSON(data: data!)
            } else {
                print ("Failure! \(response!)")
            }
        })
        dataTask.resume()
    }
    
    func parseJSON(data: Data) -> String {
        let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject]
        if let json = json {
            DispatchQueue.main.async {
                self.greetingLabel.text = (json["content"] as! String ?? "Empty Data")
            }
        }
        return ""
    }
}
