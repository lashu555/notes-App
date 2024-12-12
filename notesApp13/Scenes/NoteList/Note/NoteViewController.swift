//
//  NoteViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import UIKit

class NoteViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var titleField: UITextView!
    @IBOutlet weak var bodyField: UITextView!
    @IBOutlet weak var createdAtLabel: UILabel!
    //MARK: Properties
    var note: Note?
    var noteCopy: Note?
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCopyForChecking()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNoteSelector))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editNoteSelector))
        setUpNote()
        // Do any additional setup after loading the view.
    }
    
    //MARK: private Methods
    private func setUpNote(){
        createdAtLabel.text = "Created at \(note?.createdAt ?? Date())"
        createdAtLabel.clipsToBounds = true
        titleField.text = note?.title
        bodyField.text = note?.body
    }
    
    private func deleteNote(){
        guard let id = note?.id else { return }
        NoteDataSource.shared.notes.removeAll(where: { $0.id == id })
        navigationController?.popViewController(animated: true)
    }
    private func editNote() {
        guard let noteId = note?.id else { return }
        NoteDataSource.shared.editedNote(
            id: noteId,
            title: titleField.text ?? "",
            body: bodyField.text ?? "",
            editedAt: Date()
        )
    }
    private func saveWithBackButton(shouldSave: Bool){
        if shouldSave{
            editNote()
        }
    }
    private func createCopyForChecking() -> Void{
       noteCopy = note
    }
    private func checkIfEditedNote(noteCopy: Note) -> Bool{
        if noteCopy.title != titleField?.text || noteCopy.body != bodyField?.text{
            return true
        }
        return false
    }
    // MARK: objc funcs
    @objc func deleteNoteSelector(){
        deleteNote()
    }
    @objc func editNoteSelector(){
        if titleField.text?.isEmpty ?? true && bodyField.text?.isEmpty ?? true{
            deleteNote()
        }
        saveWithBackButton(shouldSave: checkIfEditedNote(noteCopy: noteCopy!))
        navigationController?.popViewController(animated: true)
        }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
