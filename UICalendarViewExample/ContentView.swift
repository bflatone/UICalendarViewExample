//
//  ContentView.swift
//  UICalendarViewExample
//
//  Created by SwiftMan on 2022/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var calendarIdentifier: Calendar.Identifier = .gregorian
    @State private var selectedDate: Date? = Date.now
    
    private var textSelectedDate: String {
        guard let selectedDate else {return "Date not selected"}
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
        return selectedDate.formatted(date: .complete, time: .omitted)
    }
    
    
    var body: some View {
        TabView{
            VStack{
                Text(selectedDate!.formatted(date: .complete, time: .omitted))
                    .font(.title)
                ScrollView {
                    CalendarView()
                        .frame(minWidth: 220, minHeight: 280)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300)
                        .border(.red)
                }
                .border(.teal)
                Text("See how it aligns to text below")
            }

//            .frame(width:300)
            .tabItem {
                Label("Cal1", systemImage: "calendar")
                    .toolbar{
                            Text("item 1")
                    }
            }
            VStack{
                Text(selectedDate!.formatted(date: .complete, time: .omitted))
                    .font(.title)
                CalendarView2(canSelect: true, selectedDate: $selectedDate)
                    .frame(width:300, height: 400)
                    .border(.red)
                
                Text("See how it aligns to text below")
                
            }
            .frame(width:300)
            .tabItem {
                Label("Cal2", systemImage: "calendar")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
