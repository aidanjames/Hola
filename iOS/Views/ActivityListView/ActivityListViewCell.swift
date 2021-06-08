//
//  ActivityListViewCell.swift
//  Hola
//
//  Created by Aidan Pendlebury on 16/05/2021.
//

import SwiftUI

struct ActivityListViewCell: View {
    
    var activity: Activity
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.description)
                        .font(.headline)
                        .bold()
                        .padding(.bottom, 5)
                        .lineLimit(1)
                    Text("Start:  \(activity.startTime.friendlyDate())")
                        .foregroundColor(.secondary)
                    Text("End:    \(activity.wrappedEndTime)")
                        .foregroundColor(.secondary)
                    Text("Total:  \(activity.totalTimeInSeconds.convertToFriendlyTimeInterval())")
                        .foregroundColor(.secondary)
                }
                .padding()
                Spacer()
                Button("Edit") {
                    // To do
                }
                .padding()
            }
            
        }.font(.callout)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
    }
}

struct ActivityListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListViewCell(activity: MockActivities.singleActivity)
    }
}
