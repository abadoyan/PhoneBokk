//
//  Contact+CoreDataClass.swift
//  PhoneBook
//
//  Created by Badoyan Arman on 1/27/18.
//  Copyright © 2018 Badoyan Arman. All rights reserved.
//

import Foundation
import CoreData

@objc(Contact)
public class Contact: NSManagedObject {
    
    @NSManaged public var name: String
    @NSManaged public var num: String
    @NSManaged public var image: Data?
    

}
