//
//  IGFeedPostTableViewCell.swift
//  InstagramApp
//
//  Created by Stefan Dojcinovic on 25.7.21..
//

import UIKit
import SDWebImage
import AVFoundation

/// Cell for primary post content( video or image )
final class IGFeedPostTableViewCell: UITableViewCell {
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    static let identifier = "IGFeedPostTableViewCell"
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
        return
        
        // Configure the cell
        switch post.postType {
        case .photo:
            // Show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // Load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postImageView.frame = contentView.bounds
        playerLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
}
