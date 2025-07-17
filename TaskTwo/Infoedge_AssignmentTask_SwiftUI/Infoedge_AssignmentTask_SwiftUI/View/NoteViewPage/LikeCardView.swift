//
//  Untitled.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 17/07/25.
//
import SwiftUI
 import SDWebImageSwiftUI
struct LikeCardView: View {
    let profile: LikeProfile
    let blur: Bool
    
    var body: some View {
        VStack {
            ZStack {
                
                if let url = URL(string: profile.avatar) {
                    WebImage(url: url)
                        .resizable()
                    
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                        .cornerRadius(12)
                        .clipped()
                }
                else {
                    Color.gray
                        .frame(height: 250)
                        .cornerRadius(12)
                }
                if blur {
                    Rectangle()
                        .fill(Color.white.opacity(0.6))
                        .frame(height: 120)
                        .cornerRadius(12)
                        .blur(radius: 8)
                }
            }
            
            Text(profile.first_name)
                .font(.caption)
                .padding(.top, 4)
        }
    }
}
