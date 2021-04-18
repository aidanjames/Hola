//
//  View+Ext.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 18/04/2021.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 5))
    }
}
