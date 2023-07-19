//
//  TimeInputController.swift
//  NotesApp
//
//  Created by Macbook on 06/07/23.
//

import UIKit
import UserNotifications

class TimeInputController: UIViewController {
    
    var timeString: String = ""
    var mainVCObj = MainViewController()
    @IBOutlet weak var datePicker: UIDatePicker!
    let noticenter = UNUserNotificationCenter.current()
    
    @IBAction func clickToMainVC(_ sender: Any) {
        noticenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                
                if(settings.authorizationStatus == .authorized){
                    let content = UNMutableNotificationContent()
                    let picker = self.datePicker.date
                    content.title = "Notification"
                    content.body = "This is notification"
                    
                    content.sound = UNNotificationSound.default
                    var dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: picker)
                    print("++++++++++++++++++++++++++++++++")
                    print(dateComp)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    self.noticenter.add(request){
                        (error) in
                        
                    }
                    let ac = UIAlertController(title: "Notification set", message: "At ", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                } else {
                    let ac = UIAlertController(title: "Enable Notifications?", message: "you must enable notifications in settings", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .default))
                    self.present(ac, animated: true)
                    }
                }
            }
    }
    func formattedDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        noticenter.requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed{
                print("Permission granted")
            }
            else
            {
                print("Error occured or Permission not granted")
            }
        }
        // Do any additional setup after loading the view.
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
