//
//  Media+CoreDataProperties.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//
//

import Foundation
import CoreData


extension Media {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Media> {
        return NSFetchRequest<Media>(entityName: "Media")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
