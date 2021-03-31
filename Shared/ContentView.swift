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
    @State private var stories = [Story]()
    @State private var paragraphs = [Paragraph]()
    @State private var selectedStoryTitle = ""
    
    var translateButtonDisabled: Bool { es.isEmpty || isFetchingTranslation }
    
    var body: some View {
        VStack {
                ForEach(stories) { story in
                    Button(story.title) {
                        fetchStoryText(id: story.id)
                    }
                    .padding()
                }
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
            Button(action: { fetchStories() } ) {
                Text("Fetch stories")
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
    
    func fetchStories() {
        isFetchingTranslation = true
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/all-stories") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let parsedResponse = try decoder.decode(AllStoriesResponse.self, from: data)
                    print(parsedResponse)
                    stories = parsedResponse.response.stories
                    isFetchingTranslation = false
                } catch {
                    print("Failed to parse response. Error", error.localizedDescription)
                    isFetchingTranslation = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                isFetchingTranslation = false
            }
        }
    }
    
    func fetchStoryText(id: Int) {
        isFetchingTranslation = true
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/fetch-story?id=\(id)") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let parsedResponse = try decoder.decode(StoryResponse.self, from: data)
                    print(parsedResponse)
                    paragraphs = parsedResponse.response.paragraphs
                    selectedStoryTitle = parsedResponse.response.storyTitle
                    isFetchingTranslation = false
                } catch {
                    print("Failed to parse response. Error", error.localizedDescription)
                    isFetchingTranslation = false
                }
            case .failure(let error):
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
