//
//  ActivityListView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 15/05/2021.
//

import SwiftUI

struct ActivityListView: View {
    
    @State private var activities: [Activity] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                LazyVStack {
                    ForEach(activities) { activity in
                        ActivityListViewCell(activity: activity)
                            .padding(.bottom, 2)
                            .padding(.horizontal)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Activities")
            .onAppear {
                activities = MockActivities.multipleActivities
            }
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
