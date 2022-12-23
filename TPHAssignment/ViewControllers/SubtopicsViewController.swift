//
//  MeditationsViewController.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/21/22.
//

import Foundation
import UIKit
import SDWebImage

class SubtopicsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var subtopics: [SubtopicEntity] = []
    var parentMeditations: [MeditationEntity] = []
   
    private var subtopicMeditations: [[MeditationEntity]] {
        var meditations: [[MeditationEntity]] = []
        for subtopic in subtopics {
            meditations.append(subtopic.meditationsArray)
        }
        return meditations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SubtopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        subtopics.count + (parentMeditations.isEmpty ? 0 : 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !parentMeditations.isEmpty, section == tableView.numberOfSections - 1 {
            return parentMeditations.count
        }
        return subtopics[section].meditations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MeditationCell") as? MeditationTableViewCell else { return UITableViewCell() }
        
        let meditation: MeditationEntity
        if !parentMeditations.isEmpty && indexPath.section == tableView.numberOfSections - 1 {
            meditation = parentMeditations[indexPath.row]
        } else {
            meditation = subtopicMeditations[indexPath.section][indexPath.row]
        }
        
        cell.titleLabel.text = meditation.title
        cell.teacherLabel.text = meditation.teacherName
        
        if let imageUrl = meditation.imageUrl, let url = URL(string: imageUrl) {
            cell.thumbnailImageView.sd_setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !parentMeditations.isEmpty, section == tableView.numberOfSections - 1 {
         return "Meditations"
        }
        return subtopics[section].title
    }
}
