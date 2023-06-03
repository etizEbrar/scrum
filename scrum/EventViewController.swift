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
        
        datePicker.datePickerMode = .date
        startDatePicker.datePickerMode = .time
        endDatePicker.datePickerMode = .time

        
    }
    
    
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let eventDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        let eventDate = Calendar.current.date(from: eventDateComponents)
        let event = PFObject(className: "Event")
        event["date"] = eventDate
        event["start_time"] = startDatePicker.date
        event["end_time"] = endDatePicker.date
        event["event_type"] = eventTypeText.text
        event["details"] = detailsText.text
        
        event.saveInBackground { (success, error) in
            if let error = error {
                print("Error saving event: \(error.localizedDescription)")
                // Hata durumunda yapılacak işlemler...
            } else {
                print("Event saved!")
                // Başarılı kaydetme durumunda yapılacak işlemler...
            }
        }
        
        // Tarih ve saatleri formatlayarak UI elemanlarına atama
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone.current
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        startTimeLabel.text = timeFormatter.string(from: startDatePicker.date)
        endTimeLabel.text = timeFormatter.string(from: endDatePicker.date)
        
        // Diğer UI elemanlarını sıfırlama
        eventTypeText.text = ""
        detailsText.text = ""
        eventTypeText.resignFirstResponder()
        detailsText.resignFirstResponder()
    }
}
    

