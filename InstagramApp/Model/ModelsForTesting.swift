//
//  modelsForTesting.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 28.7.21..
//

import Foundation

struct TestModels {
    
    static let testUser = User(profilePhoto: URL(string: "https://www.google.com")!,
                           username: "Joe",
                           bio: "",
                           name: (first: "Joe", last: "Smith"),
                           birthDate: Date(),
                           gender: .male,
                           count: UserCount(followers: 1, following: 1, posts: 1),
                           joinDate: Date())
    
    static let testPost = UserPost(identifier: "joe123",
                               postType: .photo,
                               thumbnailImage: URL(string: "https://www.google.com")!,
                               postURL: URL(string: "https://www.google.com")!,
                               caption: nil,
                               likeCount: [],
                               comments: [],
                               createdDate: Date(),
                               taggedUsers: [],
                               owner: testUser)
    
    static let testComment = PostComment(identifier: "123test",
                                         username: "@dave",
                                         text: "great!",
                                         createdDate: Date(),
                                         likes: [])
    
    enum userType {
        case followers
        case following
    }
    
    static func createUserRelationship(type: userType) -> [UserRelationship] {
        switch type {
        case .followers:
            var mockData = [UserRelationship]()
            for i in 0..<10 {
                mockData.append(UserRelationship(username: "@jane_smith",
                                                 name: "Jane Smith",
                                                 type: i % 2 == 0 ? .following : .not_following))
            }
            return mockData
        case .following:
            var mockData = [UserRelationship]()
            for i in 0..<10 {
                mockData.append(UserRelationship(username: "@joe_smith",
                                                 name: "Joe Smith",
                                                 type: i % 2 == 0 ? .following : .not_following))
            }
            return mockData
        }
    }
    
    static func createTestComments() -> [PostComment] {
        var comments = [PostComment]()
        for _ in 0..<4 {
            comments.append(testComment)
        }
        return comments
    }
    
    static let testHomeFeedRenderViewModel = HomeFeedRenderViewModel(
        header: PostRenderViewModel(renderType: .header(provider: testUser)),
        post: PostRenderViewModel(renderType: .primaryContent(provider: testPost)),
        actions: PostRenderViewModel(renderType: .actions(provider: "123")),
        comments: PostRenderViewModel(renderType: .comments(comments: createTestComments())))
    
    static func createMockModelsForHomeVC() -> [HomeFeedRenderViewModel] {
        var models = [HomeFeedRenderViewModel]()
        for _ in 0..<5 {
            models.append(testHomeFeedRenderViewModel)
        }
        return models
    }
}
