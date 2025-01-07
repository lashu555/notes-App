//
//  NoteCollectionViewCell.swift
//  notesApp13
//
//  Created by Lasha Tavberidze on 09.12.24.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private let noteLabel = UILabel()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 8
        let labelWidth = bounds.width - 2 * padding
        let labelHeight = noteLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)).height
        noteLabel.frame = CGRect(x: padding, y: padding, width: labelWidth, height: labelHeight)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.1
        self.backgroundColor = .white
    }

    // MARK: Private Methods
    private func setupViewsIfNeeded() {
        if noteLabel.superview == nil {
            noteLabel.numberOfLines = 3
            noteLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
            noteLabel.textColor = .darkText
            noteLabel.textAlignment = .left
            addSubview(noteLabel)
        }
    }

    func configure(with noteTitle: String) {
        noteLabel.text = noteTitle.isEmpty ? "Untitled Note" : noteTitle
    }
}
