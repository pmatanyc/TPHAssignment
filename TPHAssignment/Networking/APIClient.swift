//
//  APIClient.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/21/22.
//

import Foundation

final class APIClient {
    private static let TopicsURL = "https://tenpercent-interview-project.s3.amazonaws.com/topics.json"
    private static let SubtopicsURL = "https://tenpercent-interview-project.s3.amazonaws.com/subtopics.json"
    private static let MeditationsURL = "https://tenpercent-interview-project.s3.amazonaws.com/meditations.json"
    
    private enum APIError: Error {
        case internalError
        case serverError
        case parsingError
    }
    
    private let dataManager = DataManager.shared
    
    func fetchMeditationData() async throws -> [TopicEntity] {
        do {
            
            let topics = dataManager.fetchTopics()
            if !topics.isEmpty {
                return topics
            } else {
                let topics = try await fetchTopics()
                let subtopics = try await fetchSubtopics()
                let meditations = try await fetchMeditations()
                dataManager.saveMeditationData(topics: topics, subtopics: subtopics, meditations: meditations)
                return dataManager.fetchTopics()
            }
        } catch let error {
            throw error
        }
    }
    
    private func fetchTopics() async throws -> Topics {
        guard let url = URL(string: Self.TopicsURL) else { throw APIError.internalError  }

        return try await call(with: url)
    }
    
    private func fetchSubtopics() async throws -> Subtopics {
        guard let url = URL(string: Self.SubtopicsURL) else { throw APIError.internalError  }
        
        return try await call(with: url)
    }
    
    private func fetchMeditations() async throws -> Meditations {
        guard let url = URL(string: Self.MeditationsURL) else { throw APIError.internalError  }
        
        return try await call(with: url)
    }
    
    private func call<T: Codable>(with url: URL) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                throw APIError.parsingError
            }
        } catch {
            throw APIError.serverError
        }
    }
}
