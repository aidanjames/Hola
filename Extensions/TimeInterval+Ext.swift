//
//  TimeInterval+Ext.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 01/06/2021.
//

import Foundation

extension TimeInterval {
    
    func convertToFriendlyTimeInterval() -> String {
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
    
}
