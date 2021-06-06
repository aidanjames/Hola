//
//  EditActivityView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 04/06/2021.
//

import SwiftUI

struct EditActivityView: View {
    
    var activityID: UUID
    var viewModel: EditActivityViewModel
    
    var body: some View {
        Text(viewModel.activityToEdit.description)
    }
}

struct EditActivityView_Previews: PreviewProvider {
    static var previews: some View {
        EditActivityView(activityID: MockActivities.singleActivity.id, viewModel: EditActivityViewModel(id: UUID()))
    }
}
