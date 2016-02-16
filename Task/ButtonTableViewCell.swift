//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Cameron Moss on 2/13/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var delegate: ButtonTableViewCellDelegate?

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        
       if let delegate = delegate {
            delegate.buttonCellButtonTapped(self)
        }
        
    }
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            button.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            button.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }

}

protocol ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
    
}
extension ButtonTableViewCell {
    
    func updateWith(task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete!.boolValue)
    }
    
}
