//
//  TopicEntity+CoreDataProperties.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//
//

import Foundation
import CoreData


extension TopicEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopicEntity> {
        return NSFetchRequest<TopicEntity>(entityName: "TopicEntity")
    }

    @NSManaged public var color: String?
    @NSManaged public var featured: Bool
    @NSManaged public var position: Int32
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var meditations: Set<MeditationEntity>
    @NSManaged public var subtopics: Set<SubtopicEntity>
    
    var subtopicsArray: [SubtopicEntity] {
        Array(subtopics.sorted { $0.position < $1.position })
    }
    
    var meditationsArray: [MeditationEntity] {
        Array(meditations.sorted { $0.playCount > $1.playCount })
    }
}

// MARK: Generated accessors for meditations
extension TopicEntity {

    @objc(addMeditationsObject:)
    @NSManaged public func addToMeditations(_ value: MeditationEntity)

    @objc(removeMeditationsObject:)
    @NSManaged public func removeFromMeditations(_ value: MeditationEntity)

    @objc(addMeditations:)
    @NSManaged public func addToMeditations(_ values: Set<MeditationEntity>?)

    @objc(removeMeditations:)
    @NSManaged public func removeFromMeditations(_ values: Set<MeditationEntity>?)

}

// MARK: Generated accessors for subtopics
extension TopicEntity {

    @objc(addSubtopicsObject:)
    @NSManaged public func addToSubtopics(_ value: SubtopicEntity)

    @objc(removeSubtopicsObject:)
    @NSManaged public func removeFromSubtopics(_ value: SubtopicEntity)

    @objc(addSubtopics:)
    @NSManaged public func addToSubtopics(_ values: Set<SubtopicEntity>?)

    @objc(removeSubtopics:)
    @NSManaged public func removeFromSubtopics(_ values: Set<SubtopicEntity>?)

}

extension TopicEntity : Identifiable {

}
