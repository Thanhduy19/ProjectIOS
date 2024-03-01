//
//  SaveData.swift
//  CoreData_App
//
//  Created by Macbook on 24/03/2023.
//

import Foundation
import CoreData
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

func saveContext(){
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
