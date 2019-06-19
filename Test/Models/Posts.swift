//
//  PostResponse.swift
//  Test
//
//  Created by Siju on 03/05/19.
//  Copyright © 2019 SijuKarunakaran. All rights reserved.
//

import UIKit

public typealias Posts = [Post]

public struct Post: Codable {
    let id, createdAt, updatedAt: String
    let width, height: Int
    let color: String
    let description: String?
    let urls: Urls
    let links: PostResponseLinks
    let sponsored: Bool
    let likes: Int
    let likedByUser: Bool
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color, description
        case urls, links, sponsored
        case likes
        case likedByUser = "liked_by_user"
        case user
    }
}

struct PostResponseLinks: Codable {
    let purpleSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case purpleSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

struct User: Codable {
    let id, updatedAt, username, name: String
    let firstName, lastName: String
    let twitterUsername, portfolioURL, bio, location: String?
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos: Bool
    

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
    }
}

struct UserLinks: Codable {
    let purpleSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case purpleSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

struct ProfileImage: Codable {
    let small, medium, large: String
}
