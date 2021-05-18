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
            Text(activity.description)
            Text(" Start: \(activity.startTime.friendlyDate())")
            Text("End: \(activity.wrappedEndTime)")
        }
        .frame(height: 200)
    }
}

struct ActivityListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListViewCell(activity: MockActivities.singleActivity)
    }
}
