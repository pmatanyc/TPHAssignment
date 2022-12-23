//
//  Topics.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//

import Foundation

struct Topic: Codable {
    let uuid: String
    let title: String
    let position: Int
    let meditations: [String]
    let featured: Bool
    let color: String
}

struct Topics: Codable {
    let all: [Topic]
}

private extension Topics {
    enum CodingKeys: String, CodingKey {
        case all = "topics"
    }
}
