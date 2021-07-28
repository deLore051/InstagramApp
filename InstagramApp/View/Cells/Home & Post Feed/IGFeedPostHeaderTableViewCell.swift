//
//  IGFeedPostHeaderTableViewCell.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 25.7.21..
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    public weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .orange
        return imageView
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "@joe_smith"
        label.backgroundColor = .secondarySystemBackground
        label.textAlignment = .center
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: User) {
        // Configure the cell
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        // profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
        
    }
    
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePhotoImageView.image = nil
        usernameLabel.text = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 10
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: size,
                                             height: size)
        profilePhotoImageView.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - 5 - size,
                                  y: 5,
                                  width: size,
                                  height: size)
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10,
                                     y: 5,
                                     width: contentView.width - size * 2 - 25,
                                     height: contentView.height - 10)
    }
}
