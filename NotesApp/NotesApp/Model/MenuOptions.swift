//
//  MenuOptions.swift
//  NotesApp
//
//  Created by Macbook on 29/06/23.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case Profile
    case Reminders
    case Trash
    case Logout
    
    var description: String{
        switch self{
            
        case .Profile: return "profile"
        case .Reminders: return "reminder"
        case .Trash: return "trash"
        case .Logout: return "logout"
        }
    }
    
//    var image: UIImage{
//        switch self{
//
//        case .Profile: return UIImage(named: "user") ?? UIImage()
//        case .Inbox: return UIImage(named: "email") ?? UIImage()
//        case .Notifications: return UIImage(named: "menu") ?? UIImage()
//        case .Settings: return UIImage(named: "setting") ?? UIImage()
//        }
//    }
}
