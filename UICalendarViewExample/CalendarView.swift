//
//  CalendarView.swift
//  UICalendarViewExample
//
//  Created by SwiftMan on 2022/09/21.
//

import Foundation
import SwiftUI

struct CalendarView: UIViewControllerRepresentable {
    
  typealias UIViewControllerType = CalendarViewController
  func makeUIViewController(context: Context) -> CalendarViewController {
    return CalendarViewController()
  }
  
  func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {
    print(#function)
  }
}
