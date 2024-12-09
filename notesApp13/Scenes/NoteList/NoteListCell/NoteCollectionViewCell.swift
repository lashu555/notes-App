//
//  NoteCollectionViewCell.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    //MARK: properties
    private var noteLabel = UILabel()
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        noteLabel.frame = bounds
    }
    //MARK: Private Methods
    private func setupViews() {
        noteLabel.backgroundColor = .systemYellow
        noteLabel.numberOfLines = 3
        addSubview(noteLabel)
    }
    func configure(with noteTitle: String) {
        noteLabel.text = noteTitle.isEmpty ? "Untitled Note" : noteTitle
    }
}
