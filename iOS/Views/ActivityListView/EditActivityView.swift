//
//  EditActivityView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 04/06/2021.
//

import SwiftUI

struct EditActivityView: View {
    
    var activity: Activity
    
    var body: some View {
        Text(activity.description)
    }
}

struct EditActivityView_Previews: PreviewProvider {
    static var previews: some View {
        EditActivityView(activity: MockActivities.singleActivity)
    }
}
