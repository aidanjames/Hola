//
//  ActivityListViewModel.swift
//  Hola
//
//  Created by Aidan Pendlebury on 28/05/2021.
//

import Foundation

struct ActivityError: Identifiable {
    var id = UUID()
    var text: String
}

final class ActivityListViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var error: ActivityError? = nil
    @Published var activityBeingEdited: UUID? = nil
    
    
    func fetchActivities() {
        if let savedActivities: [Activity] = FileManager.default.fetchData(from: "Activities") {
            activities = savedActivities
        } else {
            activities = MockActivities.multipleActivities
        }
    }
    
    
    func deleteActivity(id: UUID) {
        if let index = activities.firstIndex(where: { $0.id == id } ) {
            activities.remove(at: index)
            saveActivities()
        } else {
            error = ActivityError(text: "Couldn't find activity to delete")
        }
    }
    
    
    func edit(activity: Activity) {
        if let index = activities.firstIndex(where: { $0.id == activity.id } ) {
            activities[index] = activity
            saveActivities()
        } else {
            error = ActivityError(text: "Couldn't find activity to update")
        }
    }
    
    
    private func saveActivities() {
        FileManager.default.writeData(activities, to: "Activities")
    }

}
