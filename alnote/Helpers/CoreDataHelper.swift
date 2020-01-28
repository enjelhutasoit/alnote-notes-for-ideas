//
//  CoreDataHelper.swift
//  alnote
//
//  Created by Enjelina on 28/01/20.
//  Copyright © 2020 enjelhutasoit. All rights reserved.
//

import UIKit
import CoreData

// CREATING HELPER METHODS
//  create a computed class variable that gets a reference to our app delegate's managed object context. We can use our reference to our NSManagedObjectContext to create, edit and delete NSManagedObject objects.

// This class methods that we can use to add, update, retrieve, and delete notes

struct CoreDataHelper {
    // Step-1:  Create a computed class variable that gets a reference to our app delegate's managed object context
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
        
    }()
    
    // Step-2: Create note
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    // Step-3: Read note
    static func retrieveNotes() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)

            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")

            return []
        }
    }
    
    // Step-4: Save Note
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    // Step-5: Delete note
    static func delete(note: Note) {
        context.delete(note)
        saveNote()
    }
    
    
}
