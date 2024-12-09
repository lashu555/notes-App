//
//  ViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import UIKit

class NoteListViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var noteCollection: UICollectionView!
    @IBOutlet weak var viewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var notesCountLabel: UILabel!
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        setUpNoteCollection()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.noteCollection.reloadData()
            let noteCount = NoteDataSource.shared.notes.count
            self.notesCountLabel.text = "\(noteCount == 1 ? "\(noteCount) note" : "\(noteCount) notes")"
        }
    }
    private func setUpNoteCollection(){
        navigationController?.title = "Notes"
        noteCollection.delegate = self
        noteCollection.dataSource = self
        noteCollection.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "noteCell")
        noteCollection.reloadData()
        notesCountLabel.text = "\(NoteDataSource.shared.notes.count) notes"
    }
    @objc func addNote(){
        let newNote = Note(id: UUID(), title: "", body: "", createdAt: Date())
        NoteDataSource.shared.notes.append(newNote)
        moveToNote(note: newNote)
        
    }
    private func moveToNote(note: Note){
        guard let vc = UIStoryboard(name: "Note", bundle: nil).instantiateViewController(identifier: "NoteSbID") as? NoteViewController else {
            print("couldn't instantiate!")
            return
        }
        vc.note = note
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - extensions 1/3 UICollectionViewDelegate
extension NoteListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToNote(note: NoteDataSource.shared.notes[indexPath.row])
    }
}
//MARK: - extensions 2/3 UICollectionViewDataSource
extension NoteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NoteDataSource.shared.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as! NoteCollectionViewCell
        cell.configure(with: NoteDataSource.shared.notes[indexPath.row].title)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
}
//MARK: - extensions 3/3 UICollectionViewDelegateFlowLayout
extension NoteListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 165
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
