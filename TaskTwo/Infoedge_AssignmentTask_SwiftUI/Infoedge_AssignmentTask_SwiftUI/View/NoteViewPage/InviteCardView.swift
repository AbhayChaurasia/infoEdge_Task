//
//  InviteCardView.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 17/07/25.
//

import SwiftUI
 import SDWebImageSwiftUI
struct InviteCardView: View {
    let profile: InviteProfile

    var body: some View {
        VStack(alignment: .leading) {
            if let urlString = profile.photos.first?.photo,
               let url = URL(string: urlString) {
                
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity) // shows loading spinner
                    .transition(.fade(duration: 0.5)) // fade effect
                    .scaledToFill()
                    .frame(height: 250)
                    .cornerRadius(12)
                    .clipped()
                
            } else {
                Color.gray
                    .frame(height: 250)
                    .cornerRadius(12)
            }

            Text("\(profile.general_information.first_name), \(profile.general_information.age)")
                .font(.headline)

            Text("Tap to review 50+ notes")
                .font(.caption)
        }
    }
}
