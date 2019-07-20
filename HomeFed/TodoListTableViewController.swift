//
//  TodoListTableViewController.swift
//  HomeFed
//
//  Created by Kothapalli on 7/14/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class TodoListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var instructionsTableView: UITableView!
    var instructions = [InstructionDataModel]()
    
    override func viewDidLoad() {
        instructionsTableView.delegate = self
        instructionsTableView.dataSource = self
        
        let procedureInstruction = InstructionDataModel(title: "Complete the Standard Operating Procedures Form", pdfTitle: "SOP", shouldShowReviewButton: true)
        let permitInstruction = InstructionDataModel(title: "Fill out the permit", pdfTitle: "permit", shouldShowReviewButton: true)
        instructions.append(procedureInstruction)
        instructions.append(permitInstruction)
        
        instructionsTableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionTableViewCell") as? TodoListTableViewCell else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
            return cell
        }
        cell.configureWithInstruction(instruction: instructions[indexPath.row])
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < instructions.count else { return }
        let instruction = instructions[indexPath.row]
        
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Form") as? FormViewController else {
            return
        }
        vc.formName = instruction.pdfTitle
        present(vc, animated: true, completion: nil)
        
    }
    
    
}
