//
//  Bundle+Ext.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 09/01/2021.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
    
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data.init(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file).")
        }
        
        return loaded
    }
}
