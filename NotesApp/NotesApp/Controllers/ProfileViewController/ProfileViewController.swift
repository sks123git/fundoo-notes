//
//  ProfileViewController.swift
//  NotesApp
//
//  Created by Macbook on 20/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    let noteService = NoteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileData()
    }
    
    
    func fetchProfileData() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection("users").document(user.uid).getDocument { querySnapshot, error in
            if error != nil{
                return
            }
            
            guard let document = querySnapshot?.data() else {
                return
            }
            
            let firstname = document["firstname"] as? String ?? ""
            guard let lastname = document["lastname"] else {
                return
            }
            
            self.firstName.text = firstname
            self.lastName.text = lastname as? String
        }
    }
}
