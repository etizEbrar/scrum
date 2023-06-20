//
//  EventViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 31.05.2023.
//

import UIKit
import Parse
import EventKit

class EventViewController: UIViewController {
    
    let eventStore = EKEventStore()
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var eventTypeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var eventTypeText: UITextField!
    @IBOutlet weak var detailsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        
        datePicker.datePickerMode = .date
        startDatePicker.datePickerMode = .time
        endDatePicker.datePickerMode = .time
        
        
    }
    
    let notificationCenter = UNUserNotificationCenter.current()
    
     func insertEvent(store: EKEventStore, title: String, notes: String) {
        let calendars = store.calendars(for: .event)
        
        for calendar in calendars {
            if calendar.allowsContentModifications {
                let startDate = datePicker.date
                let endDate = endDatePicker.date
                
                if startDate > endDate {
                    print("Start date cannot be later than end date")
                    return
                }
                
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = notes
                
                do {
                    try store.save(event, span: .thisEvent)
                } catch {
                    print("Error saving event in calendar")
                }
            }
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let eventType = eventTypeText.text ?? ""
        let details = detailsText.text ?? ""
        
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            insertEvent(store: eventStore, title: eventType, notes: details)
        case .denied:
            print("Access denied")
        case .notDetermined:
            eventStore.requestAccess(to: .event, completion:
                                        {[weak self] (granted: Bool, error: Error?) -> Void in
                if granted {
                    self?.insertEvent(store: self!.eventStore, title: eventType, notes: details)
                } else {
                    print("Access denied")
                }
            })
        default:
            print("Unexpected case")
        }
        createReminder(title: eventType, date: datePicker.date)
        
    }
    func createReminder(title: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Reminder for the event: \(title)"
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        //        let eventDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        //        let eventDate = Calendar.current.date(from: eventDateComponents)
        //        let event = PFObject(className: "Event")
        //        event["date"] = eventDate
        //        event["start_time"] = startDatePicker.date
        //        event["end_time"] = endDatePicker.date
        //        event["event_type"] = eventTypeText.text
        //        event["details"] = detailsText.text
        //
        //        event.saveInBackground { (success, error) in
        //            if let error = error {
        //                print("Error saving event: \(error.localizedDescription)")
        //                // Hata durumunda yapılacak işlemler...
        //            } else {
        //                print("Event saved!")
        //                // Başarılı kaydetme durumunda yapılacak işlemler...
        //            }
        //        }
        //
        
        
       
            
            //        // Tarih ve saatleri formatlayarak UI elemanlarına atama
            //        let dateFormatter = DateFormatter()
            //        dateFormatter.dateFormat = "dd/MM/yyyy"
            //        dateFormatter.timeZone = TimeZone.current
            //
            //        let timeFormatter = DateFormatter()
            //        timeFormatter.dateFormat = "HH:mm"
            //
            //        dateLabel.text = dateFormatter.string(from: datePicker.date)
            //        startTimeLabel.text = timeFormatter.string(from: startDatePicker.date)
            //        endTimeLabel.text = timeFormatter.string(from: endDatePicker.date)
            //
            //        // Diğer UI elemanlarını sıfırlama
            //        eventTypeText.text = ""
            //        detailsText.text = ""
            //        eventTypeText.resignFirstResponder()
            //        detailsText.resignFirstResponder()
            //
            //
            //    }
            //}
            //extension Date {
            //    var startOfDay: Date {
            //        return Calendar.current.startOfDay(for: self)
            //    }
            //
            //    var endOfDay: Date {
            //        var components = DateComponents()
            //        components.day = 1
            //        components.second = -1
            //        return Calendar.current.date(byAdding: components, to: startOfDay)!
            //    }
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

        
    }

