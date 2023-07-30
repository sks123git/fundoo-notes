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
        case .Profile: return "Profile"
        case .Reminders: return "Reminder"
        case .Trash: return "Trash"
        case .Logout: return "Logout"
        }
    }
}
