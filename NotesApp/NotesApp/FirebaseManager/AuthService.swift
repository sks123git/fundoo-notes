//
//  AuthService.swift
//  NotesApp
//
//  Created by Macbook on 27/06/23.
//
import FirebaseCore
import FirebaseAuth
let USER_DOCUMENT_ID = "USER_DOCUMENT_ID"

class AuthService{
    
    static func login(email: String, password: String,  completion: @escaping (Error?,AuthDataResult?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){(result,error) in
            guard let user = result?.user else {
                return
            }
            defaults.set(user.uid, forKey: USER_DOCUMENT_ID)
            completion(error,result)
        }
    }
    static func signUp(email: String, password: String, firstName: String, lastName: String,  completion: @escaping (Error?,AuthDataResult?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            guard let user = result?.user else {
                return
            } //User created successfully
            let uid = user.uid
            db.collection("users").document(uid).setData(["firstname": firstName, "lastname": lastName, "UID": result!.user.uid]){ (error) in
                if error != nil{
                    //show error message
                    print("Error while signup")
                }
            }
            completion(err,result)
        }
    }
    static func logOut(completion: @escaping (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
        
    }
}
