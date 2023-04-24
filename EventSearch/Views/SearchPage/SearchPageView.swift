//
//  SearchPageView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/4/23.
//

import SwiftUI

struct SearchPageView: View {
    @State private var events: [EventItem] = []
    @State private var values = SearchFormValues()
    @State private var suggestions: [String] = []
    @State private var isShowingPopover = false
    @State private var isFetchingSuggestions = true
    @State private var isShowingResults = false
    @State private var isSearching = true
    
    let categories = ["Default", "Music", "Sports", "Arts & Theatre", "Film", "Miscellaneous"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Keyword:")
                            .foregroundColor(.secondary)
                        TextField("Required", text: $values.keyword)
                            .onSubmit {
                                isShowingPopover = true
                                isFetchingSuggestions = true
                                Task {
                                    suggestions = await fetchSuggestions(values.keyword)
                                    isFetchingSuggestions = false
                                }
                            }
                            .popover(isPresented: $isShowingPopover) {
                                if isFetchingSuggestions {
                                    ProgressView("loading...")
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("Suggestions")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding()
                                    NavigationView {
                                        if (suggestions.isEmpty) {
                                            Text("No suggestions found")
                                        } else {
                                            List{
                                                ForEach(suggestions, id: \.self) { item in
                                                    Button(action: {
                                                        values.keyword = item
                                                        isShowingPopover = false
                                                    }) {
                                                        Text(item)
                                                            .foregroundColor(.black)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    
                    HStack {
                        Text("Distance:")
                            .foregroundColor(.secondary)
                        TextField("", text: $values.distance)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Text("Category:")
                            .foregroundColor(.secondary)
                        Picker("", selection: $values.category) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    if(!values.autoDetect) {
                        HStack {
                            Text("Location:")
                                .foregroundColor(.secondary)
                            TextField("Required", text: $values.location)
                        }
                        
                    }
                    
                    
                    HStack {
                        Text("Auto-detect my location")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .fixedSize()
                        
                        Toggle("", isOn: $values.autoDetect)
                    }
                    
                    HStack {
                        Button(action: {
                            isShowingResults = true
                            isSearching = true
                            Task{
                                let results = await search(values)
                                events = results
                                isSearching = false
                            }
                        }) {
                            Text("Submit")
                                .padding(.vertical)
                                .padding(.horizontal, 35)
                                .background(values.isFilled ? .red : .gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(!values.isFilled)
                        .buttonStyle(.borderless)
                        
                        Spacer()
                        
                        Button(action: {
                            values.reset()
                            isShowingResults = false
                        }) {
                            Text("Clear")
                                .padding(.vertical)
                                .padding(.horizontal, 35)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding()
                }
                
                if(isShowingResults) {
                    Section {
                        Text("Results")
                            .font(.title)
                            .fontWeight(.bold)
                        if(isSearching) {
                            ProgressView("Please wait...")
                                .frame(maxWidth: .infinity)
                        } else {
                            if(!events.isEmpty) {
                                List(events) { event in
                                    EventListRow(event: event)
                                }
                            } else {
                                Text("No results available")
                                    .foregroundColor(.red)
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Event Search")
            .toolbar{
                NavigationLink(destination: FavoritePageView()) {
                    Image(systemName: "heart.circle")
                }
            }
        }
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
            .environmentObject(FavoritesData())
    }
}
