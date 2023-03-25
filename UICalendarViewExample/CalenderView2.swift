//
//  CalenderView2.swift
//  UICalendarViewExample
//
//  Created by Christian Wyss on 22.03.23.
//

import SwiftUI


struct CalendarView2: UIViewRepresentable {

    @Environment(\.calendar) fileprivate var calendar

    var canSelect: Bool = false
    
    @Binding var selectedDate: Date?
    
    var dateInterval : DateInterval {
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
        return CalendarCoordinator(swiftUIView: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let calendarView = UICalendarView()
                        
        calendarView.calendar = calendar
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.backgroundColor = .green
        calendarView.availableDateRange = dateInterval
        calendarView.setVisibleDateComponents(visibleDate, animated: true)
        calendarView.layer.cornerRadius = 12

        if canSelect {
            calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
        }
        calendarView.delegate = context.coordinator

        let rootView = UIView()
        rootView.addSubview(calendarView)

        // adding constraints to profileImageView
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
          calendarView.trailingAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
          calendarView.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor, constant: 0),
          calendarView.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])

        return rootView
    }// end makeUIView

    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let calendarView = uiView.subviews.first as? UICalendarView else { return }
        calendarView.availableDateRange = dateInterval
        calendarView.reloadDecorations(forDateComponents: [visibleDate], animated: true)
    } // end updateUIView
    
}

/// Coordinator to handle
/// A) single selection events of the UICalendar:  by inheritance/override from UI UICalendarSelectionSingleDateDelegate
/// B) decorations in the UICalendar: by inheritance/ override from UICalendarViewDelegate
final class CalendarCoordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
    
    var swiftUIView: CalendarView2
    
    init(swiftUIView: CalendarView2){
        self.swiftUIView = swiftUIView
    }

    /// only days the weekdays can be selected, in this example
    /// other examples could be days that do not have time available or public holidays
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       canSelectDate dateComponents: DateComponents?) -> Bool {
        let calendar = swiftUIView.calendar
        guard
            let dateComponents,
            let date = calendar.date(from: dateComponents)
        else {return false}
        return !calendar.isDateInWeekend(date)
    }
    
    // manage the event of selection a single date
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       didSelectDate dateComponents: DateComponents?) {
        let calendar = swiftUIView.calendar
        guard
            let dateComponents,
            let date = calendar.date(from: dateComponents)
        else {return}
        swiftUIView.selectedDate = date
    }
    
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        
        return .default(color: .red, size: .large)
    }
}
