//
//  ParagraphTabView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct ParagraphTabView: View {
    
    var story: Story
    @State private var paragraphs: Paragraphs? = nil
    @State private var loadingText = ""
    @State private var showingProgressView = false
    
    var body: some View {
        NavigationView {
            if paragraphs != nil {
                TabView {
                    Text(story.title)
                        .font(.largeTitle)
                    ForEach(paragraphs!.paragraphs) {
                        ParagraphView(paragraph: $0)
                            .padding(.bottom, 50)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .navigationBarTitle(story.title, displayMode: .inline)
            } else {
                VStack {
                    if showingProgressView {
                        ProgressView(loadingText)
                    } else {
                        VStack {
                            Text(loadingText)
                                .padding()
                            Button("Try again") { fetchStoryText() }
                        }
                    }
                }
            }
            
        }
        .accentColor(Color(hex: "5f939a"))
        .onAppear {
            fetchStoryText()
        }
    }
    
    func fetchStoryText() {
        loadingText = "Loading..."
        showingProgressView = true
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/fetch-story?id=\(story.id)") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let parsedResponse = try decoder.decode(StoryResponse.self, from: data)
                    print(parsedResponse)
                    paragraphs = parsedResponse.response
                    loadingText = ""
                    showingProgressView = false
                } catch {
                    print("Failed to parse response. Error", error.localizedDescription)
                    loadingText = error.localizedDescription
                    showingProgressView = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                loadingText = error.localizedDescription
                showingProgressView = false
            }
        }
    }
}

struct ParagraphTabView_Previews: PreviewProvider {
    static var previews: some View {
        let paragraph1 = Paragraph(en: "My shoes are big.", es: "Mis zapatos son grandes.", id: 1)
        let paragraph2 = Paragraph(en: "I really like dogs.", es: "Me gustan mucho los perros.", id: 2)
        let paragraph3 = Paragraph(en: "My shoes are big.", es: "Mis zapatos son grandes.", id: 3)
        let paragraphs = Paragraphs(paragraphs: [paragraph1, paragraph2, paragraph3], storyId: 1, storyTitle: "Mi historia")
        ParagraphTabView(story: Story(id: 1, title: "Mi historia"))
    }
}
