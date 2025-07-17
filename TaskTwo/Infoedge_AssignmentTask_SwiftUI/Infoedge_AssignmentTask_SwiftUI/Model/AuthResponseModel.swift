//
//  AuthResponseModel.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 17/07/25.
//

// AuthResponse.swift
struct AuthResponse: Decodable {
    let token: String
}

// NotesResponse.swift
 
struct OTPRequest: Codable {
    let number: String
    let otp: String
}


struct NotesResponse: Codable {
    let invites: Invites
    let likes: Likes
}

struct Invites: Codable {
    let profiles: [InviteProfile]
    let pending_invitations_count: Int
}

struct InviteProfile: Codable {
    let general_information: GeneralInformation
    let photos: [Photo]
}

struct GeneralInformation: Codable {
    let first_name: String
    let age: Int
}

struct Photo: Codable {
    let photo: String
    let status: String?
}

struct Likes: Codable {
    let profiles: [LikeProfile]
    let can_see_profile: Bool
    let likes_received_count: Int
}

struct LikeProfile: Codable {
    let first_name: String
    let avatar: String
}
