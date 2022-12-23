//
//  ViewController.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/21/22.
//

import UIKit

class TopicsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    private let client = APIClient()
    private var topics: [TopicEntity] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Task {
            let topics = try await client.fetchMeditationData()
            self.topics = topics.sorted { $0.position < $1.position }
            self.activityIndicator.stopAnimating()
        }
        
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        let barButtonItem = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = barButtonItem
        activityIndicator.startAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let subtopicsVC = segue.destination as? SubtopicsViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            let topic = topics[indexPath.section]
            subtopicsVC?.parentMeditations = topic.meditationsArray
            subtopicsVC?.subtopics = topic.subtopicsArray
            subtopicsVC?.title = topics[indexPath.section].title
        }
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        topics.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as? TopicTableViewCell else { return UITableViewCell() }
        
        let topic = topics[indexPath.section]
        cell.titleLabel.text = topic.title
        cell.descriptionLabel.text = "\(topic.meditations.count + topic.subtopics.reduce(0) { $0 + $1.meditations.count }) Meditations"
        cell.colorView.backgroundColor = UIColor(hex: topic.color ?? "")
        
        return cell
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}


