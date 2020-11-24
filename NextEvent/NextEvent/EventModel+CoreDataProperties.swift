//
//  EventModel+CoreDataProperties.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-24.
//
//

import Foundation
import CoreData


extension EventModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventModel> {
        return NSFetchRequest<EventModel>(entityName: "EventModel")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var descriptionEvent: String
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var country: String
    @NSManaged public var image: String
    @NSManaged public var address: String
    @NSManaged public var date: String

}

extension EventModel : Identifiable {

}
