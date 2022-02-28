//
//  Models.swift
//  Instgram-StudyProject
//
//  Created by Mina Hany on 28/02/2022.
//

import Foundation

public struct User{
    let name: (firstname: String, lastname : String)
    let birthdate: Date
    let gender: Gender
    let bio: String
    let counts : UserCount
    let joinDate: Date
}
//MARK:  - Represent UserPost
public struct UserPost{
    let identifier: String
    let postUserType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments : [PostComment]
    let createDate: Date
    let userTagged: [String]
}

public struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
     
}

public struct PostComment{
    let text: String
    let identifier: String
    let username: String
    let userIdentifier: String
    let createdDate: Date
    let likes: [CommentLike]
}
public struct PostLikes{
    let username :String
    let postIdentifier: String
    
}

public struct CommentLike{
    let username :String
    let commentIdentifier: String
    
}
public enum UserPostType{
    case photo, vedio
}
public enum Gender{
    case male,female
}
