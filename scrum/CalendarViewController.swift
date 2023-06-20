//
//  CalendarViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 31.05.2023.
//

import UIKit
import FSCalendar
import Parse
import CoreData
import EventKit
import EventKitUI

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    let eventStore = EKEventStore()

    @IBOutlet weak var calendar: FSCalendar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self

    
    }
    // FSCalendarDelegate metotları
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let query = PFQuery(className: "Event")
               query.whereKey("date", equalTo: date)
               query.findObjectsInBackground { (events, error) in
                   if let error = error {
                       print("Error retrieving events: \(error.localizedDescription)")
                   } else if let events = events, let event = events.first {
                       self.showEventDetailsForEvent(event)
                   }
               }

       }

 


    // FSCalendarDataSource metotları

//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        // Tarihe göre etkinlik sayısını döndürmek için gerekli işlemleri gerçekleştirin
//        return 0
//    }

    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
           let query = PFQuery(className: "Event")
           query.whereKey("date", equalTo: date)
           var eventCount = 0
           query.findObjectsInBackground { (events, error) in
               if let error = error {
                   print("Error retrieving events: \(error.localizedDescription)")
               } else if let events = events {
                   eventCount = events.count
               }
           }
           return eventCount
       }

    // Yardımcı fonksiyonlar

    func showEventDetailsForEvent(_ event: PFObject) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let showEventVC = storyboard.instantiateViewController(withIdentifier: "ShowEventViewController") as? ShowEventViewController {
                showEventVC.event = event
                navigationController?.pushViewController(showEventVC, animated: true)
            }
        }


    @IBAction func addButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let eventVC = storyboard.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController {
                    navigationController?.pushViewController(eventVC, animated: true)
                }
    }
    

}
