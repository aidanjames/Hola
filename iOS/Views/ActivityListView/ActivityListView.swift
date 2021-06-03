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
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text(error.text), dismissButton: .cancel())
            }
            .navigationBarItems(trailing:
                                    Button("Show alert") {
                                        viewModel.error = ActivityError(text: "This is an error")
                                    }
            )
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
