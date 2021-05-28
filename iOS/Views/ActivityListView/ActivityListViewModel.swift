//
//  ActivityListViewModel.swift
//  Hola
//
//  Created by Aidan Pendlebury on 28/05/2021.
//

import Foundation

final class ActivityListViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    
    func fetchActivities() { activities = MockActivities.multipleActivities }
}
