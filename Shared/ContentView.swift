//
//  ContentView.swift
//  Shared
//
//  Created by Aidan Pendlebury on 08/01/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var es = ""
    @State private var en = "..."
    
    var body: some View {
        VStack {
            Text("hola!")
                .font(.largeTitle)
            TextField("Spanish to translate", text: $es)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text(en)
            Button(action: { translateText() } ) {
                Text("Translate")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            .disabled(es.isEmpty)
        }
    }
    
    func translateText() {
        en = "Translating..."
        let escapedString = es.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.lowercased()
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/translate?es=\(escapedString)") { result in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
