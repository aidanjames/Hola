//
//  Activity.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 14/05/2021.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var description = ""
    var startTime: Date
    var endTime: Date?
    var isActive: Bool { endTime != nil }
    
    var wrappedEndTime: String {
        if endTime != nil {
            return "\(endTime!.friendlyDate())"
        } else {
            return "Still timing"
        }
    }
    
    var totalTimeInSeconds: TimeInterval {
        guard endTime != nil else { return Date() - startTime }
        return endTime! - startTime
    }
}

enum MockActivities {
    static let singleActivity = Activity(description: "My task that I just made that would take up more than one line OK?", startTime: Date().add(seconds: -20000), endTime: Date().add(seconds: -10000))
    static let multipleActivities: [Activity] = [
        singleActivity,
        Activity(description: "Another task", startTime: Date().add(seconds: -8000), endTime: Date().add(seconds: -7000))
    ]
}
