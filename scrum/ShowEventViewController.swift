//
//  ShowEventViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 3.06.2023.
//

import UIKit
import Parse
import FSCalendar
import EventKit


class ShowEventViewController: UIViewController {

    var event: PFObject?


    @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var startTimeLabel: UILabel!
      @IBOutlet weak var endTimeLabel: UILabel!
      @IBOutlet weak var eventTypeLabel: UILabel!
      @IBOutlet weak var detailsLabel: UILabel!
      
    let eventStore = EKEventStore()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let event = event {
                    showEventDetailsForEvent(event)
                }

    }
    
    
      func showEventDetailsForEvent(_ event: PFObject) {
          dateLabel.text = formatDate(event["date"] as? Date)
                 startTimeLabel.text = formatTime(event["start_time"] as? Date)
                 endTimeLabel.text = formatTime(event["end_time"] as? Date)
                 eventTypeLabel.text = event["event_type"] as? String
                 detailsLabel.text = event["details"] as? String
             }
    func updateEvent(event: PFObject, newTitle: String, newDate: Date) {
          // Update event properties
          event["event_type"] = newTitle
          event["date"] = newDate
          
          // Save updated event
          event.saveInBackground()
      }

      func deleteEvent(event: PFObject) {
          event.deleteInBackground()
      }
    
    func formatDate(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return date.map { dateFormatter.string(from: $0) } ?? ""
    }

    func formatTime(_ time: Date?) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return time.map { timeFormatter.string(from: $0) } ?? ""
    }
     
      


    
//    func showEventDetailsForEvent(_ event: PFObject) {
//            self.dateLabel.text = self.formatDate(event["date"] as? Date)
//            self.startTimeLabel.text = self.formatTime(event["start_time"] as? Date)
//            self.endTimeLabel.text = self.formatTime(event["end_time"] as? Date)
//            self.eventTypeLabel.text = event["event_type"] as? String
//            self.detailsLabel.text = event["details"] as? String
//        }
//
//
//    func formatDate(_ date: Date?) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        if let date = date {
//            return dateFormatter.string(from: date)
//        }
//        return ""
//    }
//
//    func formatTime(_ time: Date?) -> String {
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "HH:mm"
//        if let time = time {
//            return timeFormatter.string(from: time)
//        }
//        return ""
//    }
//

}
