//
//  CalenderView2.swift
//  UICalendarViewExample
//
//  Created by Christian Wyss on 22.03.23.
//

import SwiftUI


struct CalendarView2: UIViewRepresentable {

    /// and property to view and set Gregorian calendar as default
    var calendarIdentifier: Calendar.Identifier = .gregorian
    var canSelect: Bool = false
    
    @Binding var selectedDate: Date?
    
    var dateInterval : DateInterval {
        
        let calendar = Calendar(identifier: calendarIdentifier)
        let startDate = Date(timeIntervalSince1970: 1677686400)
        let endDate = Date(timeIntervalSince1970: 1696089600)
        return DateInterval(start: startDate, end: endDate)
    }
    
    /// defines which part of the calendar is visible, the default is Date.now
    var visibleDate: DateComponents {
        var comps = DateComponents()
        comps.day = 1
        comps.month = 5
        comps.year = 2023
        
        return comps
    }
    
    /// creates a delegate that handles the date selections in the calendar
    func makeCoordinator() -> CalendarCoordinator {
        return CalendarCoordinator(calendarIdentifier: calendarIdentifier, selectedDate: $selectedDate)
    }
    
    func makeUIView(context: Context) -> some UICalendarView {
        let calendarView = UICalendarView()
                        
        calendarView.calendar = Calendar(identifier: calendarIdentifier)
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.backgroundColor = .green
        calendarView.availableDateRange = dateInterval
        calendarView.setVisibleDateComponents(visibleDate, animated: true)
        calendarView.layer.cornerRadius = 10
        calendarView.translatesAutoresizingMaskIntoConstraints = true
 
        
        if canSelect {
            calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        }
        calendarView.delegate = context.coordinator

        return calendarView
    }// end makeUIView
    
//    private func setupUIComponents() {
//        let calendarView = UICalendarView()
//
//       // adding constraints to profileImageView
//       calendarView.translatesAutoresizingMaskIntoConstraints = false
//       calendarView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//       calendarView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//       calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//       calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.availableDateRange = dateInterval
        uiView.reloadDecorations(forDateComponents: [visibleDate], animated: true)
    } // end updateUIView
    
}

/// Coordinator to handle
/// A) single selection events of the UICalendar:  by inheritance/override from UI UICalendarSelectionSingleDateDelegate
/// B) decorations in the UICalendar: by inheritance/ override from UICalendarViewDelegate
final class CalendarCoordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
    
    @Binding var selectedDate: Date?
    var calendarIdentifier: Calendar.Identifier
    var calendar: Calendar {
        Calendar(identifier: calendarIdentifier)
    }
    
    init(calendarIdentifier: Calendar.Identifier, selectedDate: Binding<Date?>){
        self.calendarIdentifier = calendarIdentifier
        self._selectedDate = selectedDate
    }
    
    
    /// only days on the weekend can be selected, in this example
    /// other examples could be days that do not have time available or public holidays
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       canSelectDate dateComponents: DateComponents?) -> Bool {
        guard
            let dateComponents,
            let date = calendar.date(from: dateComponents)
        else {return false}
        return !calendar.isDateInWeekend(date)
    }
    
    // manage the event of selection a single date
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       didSelectDate dateComponents: DateComponents?) {
        guard
            let dateComponents,
            let date = calendar.date(from: dateComponents)
        else {return}
        self.selectedDate = date
    }
    
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        
        return .default(color: .red, size: .large)
    }
}
