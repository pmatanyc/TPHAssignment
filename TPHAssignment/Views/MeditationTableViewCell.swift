//
//  MeditationTableViewCell.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/21/22.
//

import UIKit

class MeditationTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnailImageView.layer.cornerRadius = 6
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        titleLabel.text = nil
        teacherLabel.text = nil
    }
}
