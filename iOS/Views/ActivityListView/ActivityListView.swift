//
//  ActivityListView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 15/05/2021.
//

import SwiftUI

struct ActivityListView: View {
    
    @StateObject var viewModel = ActivityListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.activities) { activity in
                        ActivityListViewCell(activity: activity)
                            .padding(.bottom, 2)
                            .padding(.horizontal)
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Activities")
            .onAppear { viewModel.fetchActivities() }
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
