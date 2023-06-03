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
           // Seçilen tarihe göre etkinlik detaylarını getirin
           // Örneğin:
           // let event = getEventForDate(date: date)
           
           // Etkinlik detaylarını gerekli UI elemanlarına atayın
           titleLabel.text = event.title
           dateLabel.text = formatDate(event.date)
           startTimeLabel.text = formatTime(event.startTime)
           endTimeLabel.text = formatTime(event.endTime)
           eventTypeLabel.text = event.eventType
           detailsLabel.text = event.details
       }


}
