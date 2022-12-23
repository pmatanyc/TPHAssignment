//
//  Subtopics.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//

import Foundation

struct Subtopic: Codable {
    let uuid: String
    let parentTopicUuid: String
    let title: String
    let position: Int
    let meditations: [String]
}

struct Subtopics: Codable {
    let all: [Subtopic]
}

private extension Subtopics {
    enum CodingKeys: String, CodingKey {
        case all = "subtopics"
    }
}
