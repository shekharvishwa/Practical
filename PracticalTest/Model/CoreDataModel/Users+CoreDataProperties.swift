//
//  Users+CoreDataProperties.swift
//  PracticalTest
//
//  Created by Shekhar Vishwakarma on 06/07/20.
//  Copyright © 2020 shekhar. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogId: String?
    @NSManaged public var createdId: String?
    @NSManaged public var name: String?
    @NSManaged public var avatar: String?
    @NSManaged public var lastName: String?
    @NSManaged public var city: String?
    @NSManaged public var designation: String?
    @NSManaged public var about: String?

}

