//
//  VideoCell.swift
//  youtube
//
//  Created by Ayman Ata on 3/24/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import Alamofire


class ChannelCell: UITableViewCell {
    
    var video: Video? {
        didSet {
            if let videoTitle = video?.title, let channelTitle = video?.channelTitle {
                videoTitleLabel.text = videoTitle
                channelTitleLabel.text = "Channel: \(channelTitle)"
            }
            
            if let thumbnailUrl = video?.thumbURL {
                guard let videoThumbUrl = URL(string: thumbnailUrl) else { return }
                let requst = URLRequest(url: videoThumbUrl)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: requst) { (data, response, err) in
                    DispatchQueue.main.async {
                        self.videoImageView.image = UIImage(data: data!)
                    }
                }
                dataTask.resume()
            }
        }
    }

    
    let videoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let videoTitleLabel : UILabel = {
       let label = UILabel()
       label.text = "person Name"
       label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
        
       label.textColor = UIColor.white
       return label
    }()
    
    let channelTitleLabel : UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textColor = UIColor.white
       return label
    }()
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        addSubview(videoImageView)
        videoImageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        videoImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        videoImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        addSubview(videoTitleLabel)
        videoTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        videoTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoTitleLabel.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 8).isActive = true
        
        addSubview(channelTitleLabel)
        channelTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        channelTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        channelTitleLabel.topAnchor.constraint(equalTo: videoTitleLabel.bottomAnchor, constant: 10).isActive = true
    }

}
