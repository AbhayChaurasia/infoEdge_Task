//
//  NoteView.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 16/07/25.
//

import SwiftUI
import SDWebImageSwiftUI
struct NotesView: View {
    let token: String

    @State private var notesResponse: NotesResponse?
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else if let response = notesResponse {
                LoadedNotesView(response: response)
            } else {
                Text("Failed to load notes.")
                    .foregroundColor(.red)
            }
        }
        .onAppear(perform: fetchNotes)
        
        
    }
    private func fetchNotes() {
            APIService.fetchNotes(token: token) { result in
                switch result {
                case .success(let response):
                    self.notesResponse = response
                case .failure(let error):
                    print("Fetch failed:", error.localizedDescription)
                    self.notesResponse = nil
                }
                self.isLoading = false
            }
        }
    
 
}

struct LoadedNotesView: View {
    let response: NotesResponse

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Notes")
                    .font(.title)
                    .bold()

                Text("Personal messages to you")
                    .font(.subheadline)
 
                ForEach(response.invites.profiles.indices, id: \.self) { index in
                    InviteCardView(profile: response.invites.profiles[index])
                }

                // Interested In You
                HStack {
                    Text("Interested In You")
                        .font(.headline)

                    Spacer()

                    Button("Upgrade") {
                        print("Upgrade tapped")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                }

                Text("Premium members can view all their likes at once")
                    .font(.caption)

                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(response.likes.profiles.indices, id: \.self) { index in
                        let profile = response.likes.profiles[index]
                        LikeCardView(profile: profile, blur: !response.likes.can_see_profile)
                    }
                }
            }
            .padding()
        }
    }
}
