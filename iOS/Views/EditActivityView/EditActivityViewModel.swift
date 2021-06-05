//
//  EditActivityViewModel.swift
//  Hola
//
//  Created by Aidan Pendlebury on 05/06/2021.
//

import Foundation

class EditActivityViewModel: ObservableObject {
    @Published var activities: [Activity]
    @Published var activityToEdit: Activity
    @Published var description: String
    @Published var startTime: Date
    @Published var endTime: Date
    @Publisehd var error: ActivityError?
    
    init(id: UUID) {
        // Fetch saved activities
        fetchActivities()
        
        // Get the details of the activity to edit
        guard let index = activities.firstIndex(where: { $0.id == id }) else {  }
        activityToEdit = activities[index]
        description = activityToEdit.description
        startTime = activityToEdit.startTime
        endTime = activityToEdit.endTime!
    }
    

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
