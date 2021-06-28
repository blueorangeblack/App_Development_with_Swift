//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Minju Lee on 2021/06/28.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender:ToDoCell)
}

class ToDoCell: UITableViewCell {

    weak var delegate: ToDoCellDelegate?
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self) //탭된 셀자체를 보내는 것
    }
}
