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
    @State private var en = ""
    @State private var isFetchingTranslation = false
    
    var translateButtonDisabled: Bool { es.isEmpty || isFetchingTranslation }
    
    var body: some View {
        VStack {
            Text("hola!")
                .font(.largeTitle)
            TextField("Spanish to translate", text: $es)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .multilineTextAlignment(TextAlignment.center)
                .padding()
                .padding(.horizontal, 25)
            Text(en)
                .bold()
                .padding()
            Button(action: { translateText() } ) {
                Text("Translate")
                    .foregroundColor(.white)
                    .padding()
                    .background(translateButtonDisabled ? Color.gray : Color.blue)
                    .cornerRadius(16)
            }
            .disabled(translateButtonDisabled)
        }
    }
    
    func translateText() {
        en = "Translating..."
        isFetchingTranslation = true
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
                    isFetchingTranslation = false
                } catch {
                    en = "Error - Could not parse response."
                    print("Failed to parse response. Error", error.localizedDescription)
                    isFetchingTranslation = false
                }
            case .failure(let error):
                en = "Error"
                print(error.localizedDescription)
                isFetchingTranslation = false
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
