//
//  Person.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import Foundation
import CoreData
import UIKit

class Person: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var phone: String?
    @NSManaged var links: String?
    @NSManaged var gender: String?
}
