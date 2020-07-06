//
//  Blogs+CoreDataProperties.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//
//

import Foundation
import CoreData


extension Blogs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Blogs> {
        return NSFetchRequest<Blogs>(entityName: "Blogs")
    }

    @NSManaged public var id: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var content: String?
    @NSManaged public var comment: String?
    @NSManaged public var likes: String?
    @NSManaged public var media: Media?
    @NSManaged public var user: Users?
    
}
