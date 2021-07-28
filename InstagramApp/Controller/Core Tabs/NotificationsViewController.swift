//
//  NotificationsViewController.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 22.7.21..
//

import UIKit

class NotificationsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NotificationLikeEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        tableView.isHidden = false
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    // Lazy keword: Instantiate the object only when we call it
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
        //spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchNotifications() {
        for i in 0..<10 {
            let post = TestModels.testPost
            let model = UserNotification(type: i % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello World",
                                         user: TestModels.testUser)
            models.append(model)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(noNotificationsView)
        noNotificationsView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.width / 2,
                                           height: view.width / 4)
        noNotificationsView.center = view.center
    }

}


extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(post: _):
            // Like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // Follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

//MARK: - NotificationLikeEventTableViewCellDelegate

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            // Open the post
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
    }
}

//MARK: - NotificationFollowEventTableViewCellDelegate

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped button")
        // Perform database update
    }
    
    
    
}
