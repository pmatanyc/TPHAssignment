//
//  MeditationEntity+CoreDataProperties.swift
//  TPHAssignment
//
//  Created by Paola Mata Herbert on 12/22/22.
//
//

import Foundation
import CoreData


extension MeditationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeditationEntity> {
        return NSFetchRequest<MeditationEntity>(entityName: "MeditationEntity")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var playCount: Int32
    @NSManaged public var teacherName: String?
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?

}

extension MeditationEntity : Identifiable {

}
