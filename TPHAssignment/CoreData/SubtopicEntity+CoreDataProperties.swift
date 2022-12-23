//
//  SubtopicEntity+CoreDataProperties.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/23/22.
//
//

import Foundation
import CoreData


extension SubtopicEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubtopicEntity> {
        return NSFetchRequest<SubtopicEntity>(entityName: "SubtopicEntity")
    }

    @NSManaged public var position: Int32
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var parentUuid: String?
    @NSManaged public var parent: TopicEntity?
    @NSManaged public var meditations: Set<MeditationEntity>

    var meditationsArray: [MeditationEntity] {
        Array(meditations.sorted { $0.playCount > $1.playCount })
    }
}

// MARK: Generated accessors for meditations
extension SubtopicEntity {

    @objc(addMeditationsObject:)
    @NSManaged public func addToMeditations(_ value: MeditationEntity)

    @objc(removeMeditationsObject:)
    @NSManaged public func removeFromMeditations(_ value: MeditationEntity)

    @objc(addMeditations:)
    @NSManaged public func addToMeditations(_ values: Set<MeditationEntity>)

    @objc(removeMeditations:)
    @NSManaged public func removeFromMeditations(_ values: Set<MeditationEntity>)

}

extension SubtopicEntity : Identifiable {

}
