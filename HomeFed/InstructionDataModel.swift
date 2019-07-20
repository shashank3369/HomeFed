//
//  InstructionDataModel.swift
//  HomeFed
//
//  Created by Kothapalli on 7/14/19.
//  Copyright © 2019 SAV. All rights reserved.
//

import Foundation

class InstructionDataModel {
    
    let title: String
    let pdfTitle: String
    let shouldShowReviewButton: Bool
    
    init(title: String, pdfTitle: String, shouldShowReviewButton: Bool) {
        self.title = title
        self.pdfTitle = pdfTitle
        self.shouldShowReviewButton = shouldShowReviewButton
    }
}
