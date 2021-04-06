//
//  StoriesListView.swift
//  Hola
//
//  Created by Aidan Pendlebury on 01/04/2021.
//

import SwiftUI

struct StoriesListView: View {
    
    @State private var loadingText = ""
    @State private var stories: [Story] = []
    @State private var selectedStory: Story? = nil
    @State private var showingProgressView = false
    
    var body: some View {
        NavigationView {
            Group {
                if stories.isEmpty {
                    if showingProgressView {
                        ProgressView(loadingText)
                    } else {
                        VStack {
                            Text(loadingText)
                                .padding()
                            Button("Try again") { fetchStories() }
                        }
                    }
                } else {
                    if showingProgressView {
                        ProgressView("Fetching story...")
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(stories) { story in
                                    // TODO: Create a list view
                                    Button(story.title) {
                                        selectedStory = story
                                    }
                                    .padding(.vertical)
                                }
                                .sheet(item: $selectedStory) { story in
                                    ParagraphTabView(story: story)
                                }
                            }
                        }
                    }
                }
            }
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
        showingProgressView = true
        loadingText = "Loading..."
        NetworkingManager.shared.fetchData(from: "https://hola-ajp.herokuapp.com/all-stories") { result in
            print(result)
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let parsedResponse = try decoder.decode(AllStoriesResponse.self, from: data)
                    print(parsedResponse)
                    stories = parsedResponse.response.stories
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

struct StoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesListView()
    }
}
