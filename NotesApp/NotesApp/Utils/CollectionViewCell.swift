//
//  CollectionViewCell.swift
//  NotesApp
//
//  Created by Macbook on 30/06/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var index: IndexPath?
    var delegate: CollectionViewDataProtocol?
    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var labelText: UILabel!

    @IBAction func didTapToDelete(_ sender: Any) {
        delegate?.deleteData(indx: (index?.row)!)
    }
    
    @IBAction func didTapToSetNotification(_ sender: Any) {
        delegate?.setNotification(indx: (index?.row)!)
    }
}
