//
//  EditActivityView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 04/06/2021.
//

import SwiftUI

struct EditActivityView: View {
    
    @Binding var activityToEdit: Activity
    
    var body: some View {
        Text(activityToEdit.description)
    }
}

struct EditActivityView_Previews: PreviewProvider {
    static var previews: some View {
        EditActivityView(activityToEdit: .constant(MockActivities.singleActivity))
    }
}
