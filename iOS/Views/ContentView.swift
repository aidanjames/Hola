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
        NavigationView {
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
                if !en.isEmpty && !isFetchingTranslation {
                    Button("Add flash card") {
                        let newFlashCard = FlashCard(es: es, en: en)
                        var allFlashCards: [FlashCard] = FileManager.default.fetchData(from: "flashCards") ?? []
                        allFlashCards.append(newFlashCard)
                        FileManager.default.writeData(allFlashCards, to: "flashCards")
                        es = ""
                        en = ""
                    }
                    .padding()
                }
                Button(action: { translateText() } ) {
                    Text("Translate")
                        .foregroundColor(.white)
                        .padding()
                        .background(translateButtonDisabled ? Color.gray : Color.blue)
                        .cornerRadius(16)
                }
                .disabled(translateButtonDisabled)
            }
            .navigationBarTitle("Translator")
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
                    let parsedResponse = try decoder.decode(TranslationResponse.self, from: data)
                    es = parsedResponse.response.es
                    en = parsedResponse.response.en
                    isFetchingTranslation = false
                } catch {
                    en = "Error - Bad response from API."
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
