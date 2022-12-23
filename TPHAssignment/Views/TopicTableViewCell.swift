//
//  TopicTableViewCell.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/21/22.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.borderColor = UIColor(hex: "#D8D8D8")?.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 3
    }
    
    override func prepareForReuse() {
        colorView.backgroundColor = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
}
