//
//  Bundle+Ext.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 09/01/2021.
//

import Foundation

extension Bundle {
    
    // Use generics to say that we will return any kind of data, so long as it conforms to Codable
    func decode<T: Codable>(_ file: String) -> T {
    
        // 1. Get the location of the file in the app bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }

        // 2. Get the contents of the file from the url
        guard let data = try? Data.init(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        // 3. Decode the contents of file
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file).")
        }
        
        // If we're here, we can return the Codable stuff
        return loaded
    }
}
