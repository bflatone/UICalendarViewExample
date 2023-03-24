//
//  CalendarViewController.swift
//  UICalendarViewExample
//
//  Created by SwiftMan on 2022/09/21.
//

import UIKit

class CalendarViewController: UIViewController {
  let calendarView = UICalendarView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCalendar()
  }
  
  private func setupCalendar() {
    calendarView.translatesAutoresizingMaskIntoConstraints = false
    calendarView.calendar = .current
    calendarView.locale = .current
    calendarView.fontDesign = .rounded
    calendarView.delegate = self
    calendarView.layer.cornerRadius = 12
    calendarView.backgroundColor = .green
      
    calendarView.availableDateRange = DateInterval(start: .distantPast, end: .distantFuture)
    calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    
    view.addSubview(calendarView)
    
    NSLayoutConstraint.activate([
      calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
      calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    ])
  }
}

extension CalendarViewController: UICalendarViewDelegate {
  func calendarView(_ calendarView: UICalendarView,
                    decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
    print("\(#function) dateComponents: \(dateComponents)")
      return .image(UIImage(systemName: "piano"),
                    color: .blue)
  }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
  func dateSelection(_ selection: UICalendarSelectionSingleDate,
                     didSelectDate dateComponents: DateComponents?) {
//    print("\(#function) dateComponents: \(String(describing: dateComponents))")
  }
}

extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
  func multiDateSelection(_ selection: UICalendarSelectionMultiDate,
                          didSelectDate dateComponents: DateComponents) {
//    print("\(#function) selection: \(selection) dateComponents: \(dateComponents)")
  }
  
  func multiDateSelection(_ selection: UICalendarSelectionMultiDate,
                          didDeselectDate dateComponents: DateComponents) {
//    print("\(#function) selection: \(selection) dateComponents: \(dateComponents)")
  }
}
