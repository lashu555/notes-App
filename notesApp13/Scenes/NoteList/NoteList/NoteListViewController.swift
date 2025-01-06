//
//  ViewController.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import UIKit

class NoteListViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: Outlets
    @IBOutlet weak var noteCollection: UICollectionView!
    @IBOutlet weak var viewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var notesCountLabel: UILabel!
    //MARK: Properties
    var sections : [String: [Note]] = [:]
    let gradientLayer = CAGradientLayer()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        noteCollection.backgroundColor = .systemBackground.withAlphaComponent(0)
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemBackground.withAlphaComponent(0.5).cgColor,
                                UIColor.systemGray5.cgColor,
                                UIColor.systemGray6.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        navigationItem.rightBarButtonItem?.tintColor = .systemCyan
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        setUpNoteCollection()
        self.tabBarItem = UITabBarItem(
            title: "Notes",
            image: UIImage(systemName: "note.text"),
            tag: 0
        )
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .link.withAlphaComponent(0)
        let noteCount = NoteDataSource.shared.notes.count
        if noteCount != notesCountLabel.text?.count {
            notesCountLabel.text = "\(noteCount == 1 ? "\(noteCount) note" : "\(noteCount) notes")"
        }
        DispatchQueue.main.async {
            self.noteCollection.reloadData()
        }
    }
    //MARK: methods
    private func getSectionCount(sections: [String: [Note]]) -> Int{
        return sections.keys.count
    }
    func setANewNavTitle(_ user: User){
        navigationController?.title = "\(user.name)'s Notes"
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        if operation == .push {
            return CustomPush()
        } else {
            return nil
        }
    }
    private func setUpNoteCollection(){
        noteCollection.delegate = self
        noteCollection.dataSource = self
        noteCollection.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "noteCell")
        noteCollection.reloadData()
        notesCountLabel.text = "\(NoteDataSource.shared.notes.count) notes"
    }
    @objc func addNote(){
        let newNote = Note(id: UUID(), title: "", author: UserDataSource.shared.users.first!, body: "", createdAt: Date())
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
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            UIView.animate(
                withDuration: 0.2,
                delay: 0.1,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: .curveEaseIn,
                animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
                },
                completion: { finished in
                    UIView.animate(
                        withDuration: 0.2,
                        delay: 0.0,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 1.0,
                        options: .curveEaseOut,
                        animations: {
                            cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        },
                        completion: { finished in
                            self.moveToNote(note: NoteDataSource.shared.notes[indexPath.row])
                            
                            UIView.animate(
                                withDuration: 0.2,
                                delay: 0.3,
                                options: .curveEaseOut,
                                animations: {
                                    cell.transform = .identity
                                })
                        })
                })
        }
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
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.1
        cell.backgroundColor = .white
        return cell
    }
}
//MARK: - extensions 3/3 UICollectionViewDelegateFlowLayout
extension NoteListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 110.0
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 3, bottom: 0, right: 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
