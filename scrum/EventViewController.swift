//
//  EventViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 31.05.2023.
//

import UIKit
import Parse

class EventViewController: UIViewController {
    
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

        let event = PFObject(className: "Event")
        event["date"] = datePicker.date
        event["start_time"] = startDatePicker.date
        event["end_time"] = endDatePicker.date
        event["event_type"] = eventTypeText.text
        event["details"] = detailsText.text

        event.saveInBackground { (success, error) in
            if success {
                print("Event saved!")
            } else {
                print("Error saving event: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        
        // Bu kod, seçilen tarihe göre etkinliği getirmek için gerekli
        func fetchEventForSelectedDate(selectedDate: Date) {
            let query = PFQuery(className: "Event")
            query.whereKey("date", equalTo: selectedDate)
            query.findObjectsInBackground { (objects, error) in
                if let error = error {
                    print("Error retrieving event: \(error.localizedDescription)")
                } else if let events = objects {
                    // events dizisi, seçilen tarihe ait tüm etkinlikleri içerir
                    if let event = events.first {
                        // İlk etkinliği kullanarak UI elemanlarını güncelleyin
                        // Diğer etkinlik özelliklerini de ilgili UI elemanlarına ayarlayabilirsiniz
                    } else {
                        print("No event found for selected date.")
                    }
                }
            }
        }


        
    }
    
  

    
}
