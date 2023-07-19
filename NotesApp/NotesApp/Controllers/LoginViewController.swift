//
//  LoginViewController.swift
//  NotesApp
//
//  Created by Macbook on 26/06/23.
//

import UIKit
import FirebaseAuth

let defaults = UserDefaults.standard

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func loginBtnTapped(_ sender: Any) {
        let noteService = NoteService()
        //Validate text fields

        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        defaults.set(email, forKey: "email")
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        defaults.set(password, forKey: "password")
        //Signin in the user
        AuthService.login(email: email, password: password) { error,result in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let scene = UIApplication.shared.connectedScenes.first
                if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? MainViewController
                    sd.window?.rootViewController = UINavigationController(rootViewController: homeViewController!)
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
