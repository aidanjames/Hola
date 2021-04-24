//
//  Date+Ext.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 24/04/2021.
//

import Foundation

extension Date {
    
    func tomorrow() -> Date {
        let now = Calendar.current.dateComponents(in: .current, from: self)

        // Add 1 to the day to get tomorrow.
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        return Calendar.current.date(from: tomorrow)!
    }
    
    
    func addOneHour() -> Date { return self.addingTimeInterval(5) }
    
}
