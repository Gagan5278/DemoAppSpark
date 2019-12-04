//
//  PersonalityTableViewCell.swift
//  Personality_Test
//
//  Created by Gagan Vishal on 2019/12/04.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class PersonalityTableViewCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var queestionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    var questionModel: QuestionsModel! {
        didSet {
            bindModel()
        }
    }
    
    
    func bindModel() {
        queestionLabel.text =  questionModel.question
    }
    
    //MARK:- Bind model
    @IBAction func chooseAnswerButtonClicked(_ sender: Any) {
        if let viewController = self.getParentViewController() {
            let actionAlert = UIAlertController(title: "Select Answer", message: nil, preferredStyle: .actionSheet)
            //2. Add Action to ActionSheet
            for item in questionModel.question_type.options {
                actionAlert.addAction(UIAlertAction(title: item, style: .default, handler: self.selectedAnswerAlertAction(action:)))
            }
            //3. Cancel Button
            actionAlert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            //4.present ActionSheet
            viewController.present(actionAlert, animated: true, completion: nil)
        }
    }

    
    //MARK:- NotificationType Alert Action
    fileprivate func selectedAnswerAlertAction(action: UIAlertAction) {
        self.answerLabel.textColor = .blue
        self.answerLabel.text = action.title
    }
}
