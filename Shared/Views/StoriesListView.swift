//
//  StoriesListView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct StoriesListView: View {
    
    @State private var isLoading = false
    @State private var stories = [Story]()
    @State private var selectedStory: Paragraphs? = nil
    
    var body: some View {
        NavigationView {
            Group {
                if stories.isEmpty {
                    Text("Fetching data...")
                } else {
                    VStack {
                        List {
                            ForEach(stories) { story in
                                Button(story.title) {
                                    fetchStoryText(id: story.id)
                                }
                                .padding(.vertical)
                            }
                        }
                        .sheet(item: $selectedStory) { story in
                            ParagraphTabView(paragraphs: story)
                        }
                    }
                    
                }
            }
            .padding(.top)
            .navigationBarTitle("All Stories")
        }
        .onAppear {
            if stories.isEmpty {
                fetchStories()
            }
        }
        
        
    }
    
    func fetchStories() {
        print("Calling fetchStories again...")
        isLoading = true
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/all-stories") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let parsedResponse = try decoder.decode(AllStoriesResponse.self, from: data)
                    print(parsedResponse)
                    stories = parsedResponse.response.stories
                    isLoading = false
                } catch {
                    print("Failed to parse response. Error", error.localizedDescription)
                    isLoading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                isLoading = false
            }
        }
    }
    
    func fetchStoryText(id: Int) {
        isLoading = true
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/fetch-story?id=\(id)") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let parsedResponse = try decoder.decode(StoryResponse.self, from: data)
                    print(parsedResponse)
                    selectedStory = parsedResponse.response
                    isLoading = false
                } catch {
                    print("Failed to parse response. Error", error.localizedDescription)
                    isLoading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                isLoading = false
            }
        }
    }
    
}

struct StoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesListView()
    }
}
