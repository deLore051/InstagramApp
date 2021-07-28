//
//  Models.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 26.7.21..
//

import Foundation


public enum UserPostType: String{
    case photo = "Photo"
    case video = "Video"
}

enum Gender {
    case male
    case female
    case other
}

struct User {
    let profilePhoto: URL
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

// UserFollowTableViewCell

/// Indicates weather the current user if following or not following the other user
enum FollowState {
    case following
    case not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}

// NotificationViewController

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

// PostViewController

/// States of a rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}

/// Model of a rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

// HomeViewController

/// Represents one section of the HomeViewController model
struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

