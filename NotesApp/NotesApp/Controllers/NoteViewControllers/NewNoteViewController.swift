//
//  NewNoteViewController.swift
//  NotesApp
//
//  Created by Macbook on 22/06/23.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    public var completion: ((String, String, String, Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave(){
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            let uid = UUID().uuidString
            let isDeleted = false
            completion?(text, noteField.text, uid, isDeleted)
        }
    }
}
