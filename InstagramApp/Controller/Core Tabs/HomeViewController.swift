//
//  ViewController.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import UIKit
import FirebaseAuth


class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // Register cells
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedRenderModels = TestModels.createMockModelsForHomeVC()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show LoginViewController
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            // Gives us the position of the model that we want
            let position = x % 4 == 0 ? x/4 : ((x - ( x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        switch subSection {
        case 0:
            // Header
            return 1
        case 1:
            // Post
            return 1
        case 2:
            // Actions
            return 1
        case 3:
            // Comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            default:
                fatalError("Invalid case")
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            // Gives us the position of the model that we want
            let position = x % 4 == 0 ? (x / 4) : ((x - ( x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        switch subSection {
        case 0:
            // Header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.configure(with: TestModels.testUser)
                cell.delegate = self
                return cell
            default:
                fatalError()
            }
        case 1:
            // Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            default:
                fatalError()
            }
        case 2:
            // Actions
            switch model.actions.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            default:
                fatalError()
            }
        case 3:
            // Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            default:
                fatalError()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        switch subSection {
        case 0:
            // Header
            return 70
        case 1:
            // Post
            return tableView.width
        case 2:
            // Actions
            return 60
        case 3:
            // Comments
            return 50
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 50 : 0
    }
}

//MARK: - IGFeedPostHeaderTableViewCellDelegate

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate {
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Report Post",
                                            style: .destructive,
                                            handler: { [weak self] _ in
                                                guard let self = self else { return }
                                                self.reportPost()
                                                
                                            }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func reportPost() {
        
    }
}

//MARK: - IGFeedPostActionsTableViewCellDelegate

extension HomeViewController: IGFeedPostActionsTableViewCellDelegate {
    
    func didTapLikeButton() {
        print("like pressed")
    }
    
    func didTapCommentButton() {
        print("comment pressed")
    }
    
    func didTapSendButton() {
        print("send pressed")
    }
    
    
}
