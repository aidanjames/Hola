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
            VStack {
                ScrollView {
                    ForEach(activities) { activity in
                        ActivityListViewCell(activity: activity)
                            .padding(.bottom)
                            .padding(.horizontal)
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.blue)
            }

            .background(Color.secondary)
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
