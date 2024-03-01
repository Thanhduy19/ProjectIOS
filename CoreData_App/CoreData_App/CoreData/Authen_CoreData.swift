//
//  Authen_CoreData.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import Foundation
import CoreData
import UIKit

class Users: NSManagedObject {
    @NSManaged public var email: String?
    @NSManaged public var pass: String?
}
