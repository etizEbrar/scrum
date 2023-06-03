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
    // FSCalendarDelegate metotları

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Tarih değerini yıl, ay, gün bileşenlerine dönüştür
           let selectedDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)

           // Tarih sorgusu için bir başlangıç ve bitiş tarihi oluştur
           let startDate = Calendar.current.date(from: selectedDateComponents)!
           var endDateComponents = selectedDateComponents
           endDateComponents.day! += 1
           let endDate = Calendar.current.date(from: endDateComponents)!

           // Seçilen tarihle ilgili etkinlikleri sorgula
           let query = PFQuery(className: "Event")
           query.whereKey("date", greaterThanOrEqualTo: startDate)
           query.whereKey("date", lessThan: endDate)
           query.findObjectsInBackground { (events, error) in
               if let error = error {
                   print("Error retrieving events: \(error.localizedDescription)")
               } else if let events = events, let firstEvent = events.first {
                   // Etkinlik detaylarını göster
                   self.showEventDetailsForEvent(firstEvent)
               } else {
                   print("No events on selected date.")
               }
           }    }


    // FSCalendarDataSource metotları

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // Tarihe göre etkinlik sayısını döndürmek için gerekli işlemleri gerçekleştirin
        return 0
    }

    // Yardımcı fonksiyonlar

    func showEventDetailsForDate(_ date: Date) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showEventVC = storyboard.instantiateViewController(withIdentifier: "ShowEventViewController") as! ShowEventViewController
        showEventVC.selectedDate = date
        navigationController?.pushViewController(showEventVC, animated: true)
    }


    @IBAction func addButtonClicked(_ sender: Any) {
    }
    
}
