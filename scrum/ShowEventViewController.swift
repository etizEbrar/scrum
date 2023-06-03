//
//  ShowEventViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 3.06.2023.
//

import UIKit
import Parse
import FSCalendar


class ShowEventViewController: UIViewController {

    var selectedDate: Date?

    @IBOutlet weak var dateLabel: UILabel!
      @IBOutlet weak var startTimeLabel: UILabel!
      @IBOutlet weak var endTimeLabel: UILabel!
      @IBOutlet weak var eventTypeLabel: UILabel!
      @IBOutlet weak var detailsLabel: UILabel!
      
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedDate = selectedDate {
            showEventDetailsForDate(selectedDate)
        }

    }
    
    
    func showEventDetailsForDate(_ date: Date) {
        let selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
               let startOfDay = Calendar.current.date(from: selectedDateComponents)!
               let endOfDay = Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfDay)!
               
               let query = PFQuery(className: "Event")
               query.whereKey("date", greaterThanOrEqualTo: startOfDay)
               query.whereKey("date", lessThanOrEqualTo: endOfDay)
               query.findObjectsInBackground { (events, error) in
                   if let error = error {
                       print("Error retrieving events: \(error.localizedDescription)")
                   } else if let events = events {
                       if let event = events.first {
                           self.dateLabel.text = self.formatDate(event["date"] as? Date)
                           self.startTimeLabel.text = self.formatTime(event["start_time"] as? Date)
                           self.endTimeLabel.text = self.formatTime(event["end_time"] as? Date)
                           self.eventTypeLabel.text = event["event_type"] as? String
                           self.detailsLabel.text = event["details"] as? String
                       } else {
                           print("No event found for selected date.")
                       }
                   }
               }
    }



    
    func formatDate(_ date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }

    func formatTime(_ time: Date?) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        if let time = time {
            return timeFormatter.string(from: time)
        }
        return ""
    }


}
