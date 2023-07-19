//
//  TrashCollectionViewCell.swift
//  NotesApp
//
//  Created by Macbook on 09/07/23.
//

import UIKit

class TrashCollectionViewCell: UICollectionViewCell {
    var index: IndexPath?
    var delegate: TrashCollectionViewDataProtocol?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textNote: UILabel!
    
    @IBAction func permanentDelete(){
        delegate?.permanentDelete(indx: (index?.row)!)
    }
    
    @IBAction func recover(){
        delegate?.recoverData(indx: (index?.row)!)
    }
}
