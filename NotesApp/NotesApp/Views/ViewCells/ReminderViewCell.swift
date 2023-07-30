//
//  ReminderViewCell.swift
//  NotesApp
//
//  Created by Macbook on 22/07/23.
//

import UIKit

class ReminderViewCell: UICollectionViewCell {
    static let reusableID = "ReminderCell"
    
    let titlelabel = UILabel()
    let notesLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func configure(){
        addSubview(titlelabel)
        addSubview(notesLabel)
        
        titlelabel.textColor = .label
        titlelabel.adjustsFontSizeToFitWidth = true
        titlelabel.minimumScaleFactor = 0.9
        titlelabel.lineBreakMode = .byTruncatingTail
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        
        notesLabel.textColor = .label
        notesLabel.adjustsFontSizeToFitWidth = true
        notesLabel.minimumScaleFactor = 0.9
        notesLabel.lineBreakMode = .byTruncatingTail
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titlelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titlelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titlelabel.heightAnchor.constraint(equalTo: titlelabel.widthAnchor ),
            
            notesLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 12),
            notesLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            notesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            notesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
