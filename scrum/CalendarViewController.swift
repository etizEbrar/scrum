//
//  CalendarViewController.swift
//  scrum
//
//  Created by Ebrar Etiz on 31.05.2023.
//

import UIKit
import FSCalendar
import Parse

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var calendar: FSCalendar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self

    
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventViewController = storyboard?.instantiateViewController(withIdentifier: "EventViewController") as! EventViewController
            eventViewController.selectedDate = date
            navigationController?.pushViewController(eventViewController, animated: true)
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            // Etkinlik sayısını belirleyin veya 0 döndürün
            return 0
        }


    @IBAction func addButtonClicked(_ sender: Any) {
    }
    
}
