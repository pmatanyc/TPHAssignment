//
//  DataManager.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "MeditationData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveMeditationData(topics: Topics, subtopics: Subtopics, meditations: Meditations) {
        let meds = storeMeditations(meditations)
        let subs = storeSubtopics(subtopics, using: meds)
        _ = storeTopics(topics, using: subs, meditations: meds)
    }
    
    func fetchTopics() -> [TopicEntity] {
        let fetchRequest = TopicEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "featured == TRUE"
        )
        let objects = try? context.fetch(fetchRequest)
        let sorted = objects?.sorted { $0.position < $1.position }

        return sorted ?? []
    }

    private func storeTopics(_ topics: Topics, using subtopics: [SubtopicEntity], meditations: [MeditationEntity]) -> [TopicEntity] {
        let topics = topics.all.map { saveTopic($0, using: subtopics, meditations: meditations) }
        save(context: context)
        return topics
    }
    private func saveTopic(_ topic: Topic, using subtopics: [SubtopicEntity], meditations: [MeditationEntity]) -> TopicEntity {
        let entity = TopicEntity(context: context)
        entity.uuid = topic.uuid
        entity.title = topic.title
        entity.position = Int32(topic.position)
        entity.featured = topic.featured
        entity.color = topic.color
       
        entity.addToSubtopics(Set(subtopics.filter { $0.parentUuid == topic.uuid }))
        
        for id in topic.meditations {
            entity.addToMeditations(Set(meditations.filter { $0.uuid == id }))
        }

        return entity
    }
    
    private func storeSubtopics(_ subtopics: Subtopics, using meditations: [MeditationEntity])-> [SubtopicEntity] {
        let subtopics = subtopics.all.map { saveSubtopic($0, using: meditations) }
        save(context: context)
        return subtopics
    }

    private func saveSubtopic(_ subtopic: Subtopic, using meditations: [MeditationEntity]) -> SubtopicEntity {
        let entity = SubtopicEntity(context: context)
        entity.parentUuid = subtopic.parentTopicUuid
        entity.uuid = subtopic.uuid
        entity.title = subtopic.title
        entity.position = Int32(subtopic.position)

        for id in subtopic.meditations {
            entity.addToMeditations(Set(meditations.filter { $0.uuid == id }))
        }

        return entity
    }

    private func storeMeditations(_ meditations: Meditations) -> [MeditationEntity] {
        let meditations = meditations.all.map { saveMeditation($0) }
        save(context: context)
        return meditations
    }

    private func saveMeditation(_ meditation: Meditation) -> MeditationEntity {
        let entity = MeditationEntity(context: context)
        entity.uuid = meditation.uuid
        entity.title = meditation.title
        entity.teacherName = meditation.teacherName
        entity.imageUrl = meditation.imageUrl
        entity.playCount = Int32(meditation.playCount ?? 0)

        return entity
    }

    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error {
            print(error)
            fatalError("Unresolved error \(error)")
        }
    }
}
