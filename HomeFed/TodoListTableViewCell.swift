//
//  TodoListTableViewCell.swift
//  HomeFed
//
//  Created by Kothapalli on 7/14/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureWithInstruction(instruction: InstructionDataModel) {
        titleLabel.text = instruction.title
    }
}
