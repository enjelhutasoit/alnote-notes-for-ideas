//
//  DisplayNoteViewController.swift
//  alnote
//
//  Created by Enjelina on 28/01/20.
//  Copyright © 2020 enjelhutasoit. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    // MARK: - Properties
    // DISPLAYING NOTES
    var note: Note?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // DISPLAYING THE NOTE
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
    // MARK: - Navigation
    // SAVING EDITS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
            
        case "cancel":
            print("cancel button tapped")
        default:
            print("unexpected segue identifier")
        }
    }
    
}
