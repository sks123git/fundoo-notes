//
//  SignupLoginViewController.swift
//  NotesApp
//
//  Created by Macbook on 26/06/23.
//

import UIKit

var alreadyLoggedIn: Bool = false

class SignupLoginViewController: UIViewController {
    
    var noteService = NoteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkLoginStatus()
        // Do any additional setup after loading the view.
    }
    
//    func checkLoginStatus(){
//        print("checking login status")
//        let email = UserDefaults.standard.string(forKey: "email")
//
//        if email != nil {
//            alreadyLoggedIn = true
//            guard let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? MainViewController else {
//                return
//            }
//            self.navigationController?.popToRootViewController(animated: true)
//            self.navigationController?.pushViewController(homeViewController, animated: true)
//        }
//    }
}
