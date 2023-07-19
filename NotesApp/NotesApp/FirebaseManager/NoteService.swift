//
//  NoteService.swift
//  NotesApp
//
//  Created by Macbook on 27/06/23.
//
import UIKit
import FirebaseAuth

class NoteService{
    //Fetch data from data base
    func fetchData(completion: @escaping ([Note]) -> Void ) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection("users").document(user.uid).collection("notes").whereField("isDeleted", isEqualTo: false).getDocuments { querySnapshot, error in
            if error != nil{
                completion([])
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion([])
                return
            }
            let models = documents.map({ queryDocumentSnapshot -> Note  in
                let data = queryDocumentSnapshot.data()
                let uid = data["notes id"] as? String ?? ""
                let note = data["note"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let isDeleted = data["isDeleted"] as? Bool ?? false
                return Note(uid: uid, title: title, note: note, isDeleted: isDeleted)
            })
            completion(models)
        }
    }
    
    //Adding note in database
    func addToDatabase(notetitle: String, note: String, uid: String, isDeleted: Bool){
        guard let user = Auth.auth().currentUser else {
            return
        }
        let newNote = db.collection("users").document(user.uid).collection("notes").document(uid)
        newNote.setData(["notes id": uid,"title": notetitle,"note": note, "isDeleted": isDeleted]){ (error) in
            if error != nil{
                //show error message
                print(error as Any)
            }
        }
    }
    
    //Delete from database
    func deleteFromDatabase(notesDocID: String ){
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        db.collection("users").document(user.uid).collection("notes").document(notesDocID).delete()
    }
    
    //Update delete status
    func tempDeleted(notesDocID: String, isDeleted: Bool){
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection("users").document(user.uid).collection("notes").document(notesDocID).updateData(["isDeleted": isDeleted]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
