//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Michael Nguyen on 11/11/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonTapped(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.buttonCellButtonTapped(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            self.completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
    
}//End of Class

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}


