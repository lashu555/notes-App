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
        let padding: CGFloat = 8
        let labelWidth = bounds.width - 2 * padding
        let labelHeight = noteLabel.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)).height
        noteLabel.frame = CGRect(x: padding, y: padding, width: labelWidth, height: labelHeight)
    }
    //MARK: Private Methods
    private func setupViews() {
        noteLabel.numberOfLines = 3
        noteLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        noteLabel.textColor = .darkText
        noteLabel.textAlignment = .left
        addSubview(noteLabel)
    }
    func configure(with noteTitle: String) {
        noteLabel.text = noteTitle.isEmpty ? "Untitled Note" : noteTitle
    }
}
