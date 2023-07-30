//
//  BinViewController.swift
//  NotesApp
//
//  Created by Macbook on 09/07/23.
//

import UIKit

class BinViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView2: UICollectionView!
    let mainController = MainViewController()
    let noteService = NoteService()
    var recoveryItems: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRecoveryItem()
        // Do any additional setup after loading the view.
    }
    
    func setRecoveryItem(){
        noteService.fetchData(isDeleted: true) { notes in
            self.recoveryItems = notes
            self.myCollectionView2.reloadData()
        }
    }
}

extension BinViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recoveryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrashCollectionViewCell
        
        cell.title.text = recoveryItems[indexPath.item].title
        cell.textNote.text = recoveryItems[indexPath.item].note
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.index  = indexPath
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let padding: CGFloat =  5
        let minimumItemSpacing: CGFloat = 5
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth - 20, height: itemWidth - 20)
        
    }
}

extension BinViewController: TrashCollectionViewDataProtocol{
    func permanentDelete(indx: Int) {
        guard let notesDocID = recoveryItems[indx].uid else {
            return
        }
        
        noteService.deleteFromDatabase(notesDocID: notesDocID)
        recoveryItems.remove(at: indx)
        self.myCollectionView2.reloadData()
    }
    
    func recoverData(indx: Int) {
        guard let notesDocID = recoveryItems[indx].uid else {
            return
        }
        
        noteService.tempDeleted(notesDocID: notesDocID, isDeleted: false)
        mainController.models.append(recoveryItems[indx])
        recoveryItems.remove(at: indx)
        self.myCollectionView2.reloadData()
    }
}
