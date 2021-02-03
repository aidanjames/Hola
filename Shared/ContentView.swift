//
//  ContentView.swift
//  Shared
//
//  Created by Aidan Pendlebury on 08/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var es = "Loading..."
    @State private var en = "Cargando..."
    
    var body: some View {
        VStack {
            Text(es)
            Text(en)
        }
        .onAppear {
            NetworkingManager.shared.fetchData(from: "https://aidan-blog.herokuapp.com/random") { result in
                print(result)
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let parsedResponse = try decoder.decode(Response.self, from: data)
                        es = parsedResponse.response.es
                        en = parsedResponse.response.en
                    } catch {
                        print("Failed to parse response. Error", error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
