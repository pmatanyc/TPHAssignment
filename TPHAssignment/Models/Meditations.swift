//
//  Meditations.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//

import Foundation

struct Meditation: Codable {
    let uuid: String
    let title: String
    let teacherName: String
    let imageUrl: String
    let playCount: Int?
}

struct Meditations: Codable {
    let all: [Meditation]
}

private extension Meditations {
    enum CodingKeys: String, CodingKey {
        case all = "meditations"
    }
}
