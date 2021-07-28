//
//  NotificationFollowEventTableViewCell.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 27.7.21..
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowEventTableViewCell"
    
    public weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@jason_west followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height - 10
        profileImageView.frame = CGRect(x: 5,
                                        y: 5,
                                        width: imageSize,
                                        height: imageSize)
        profileImageView.layer.cornerRadius = imageSize / 2
        
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.layer.cornerRadius = buttonHeight / 5
        followButton.frame = CGRect(x: contentView.width - buttonWidth - 10,
                                    y: (contentView.height - buttonHeight) / 2,
                                  width: buttonWidth,
                                  height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right + 10,
                             y: 0,
                             width: contentView.width - imageSize - buttonWidth - 20,
                             height: contentView.height)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        switch model.type {
        case .like(let post):
            break
        case .follow(let state):
            switch state {
            case .following:
                // Show unfollow button
                configureForFollow()
            case .not_following:
                // Show follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
        }
    }
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else { return }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
