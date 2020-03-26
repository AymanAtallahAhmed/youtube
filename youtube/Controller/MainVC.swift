//
//  ViewController.swift
//  youtube
//
//  Created by Ayman Ata on 3/24/20.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import Alamofire


class MainVC: UITableViewController {

    let identifier = "cellId"
    
    var videos = [Video]()

      let API_KEY = "AIzaSyCyOEbx9zXfVdiSyteySbCR2frS8-Azzls"
      let playlistID = "PLpiER6GDq9diR5TTzxMws31oft1NGLZRJ"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getChannels()
    }
      
      func getChannels() {
        AF.request("https://www.googleapis.com/youtube/v3/playlistItems", method: .get, parameters: ["part":"snippet", "playlistId": playlistID,"key":API_KEY, "maxResults":17], encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
            
            if let JSON = response.value {
                
                var videoArray = [Video]()
                
                for JSONVideo in (JSON as! NSDictionary)["items"] as! NSArray {
                    
                    let video = JSONVideo as! Dictionary<String, Any>
                    let snippet = video["snippet"] as! Dictionary<String, Any>
                    let thumbnails = snippet["thumbnails"] as! Dictionary<String, Any>
                    let high = thumbnails["high"] as! Dictionary<String, Any>
                    
                    let videoObject = Video()
                    videoObject.title = snippet["title"] as! String
                    videoObject.thumbURL = high["url"] as! String
                    videoObject.channelTitle = snippet["channelTitle"] as! String

                    videoArray.append(videoObject)
                  }
                
                self.videos = videoArray
                self.tableView.reloadData()
              }
          }
        self.tableView.reloadData()
          
      }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar =  UIView()
        statusBar.frame = UIApplication.shared.statusBarFrame
        statusBar.backgroundColor = UIColor(red: 9/255, green: 9/255, blue: 9/255, alpha: 1)
        UIApplication.shared.keyWindow?.addSubview(statusBar)
        
        tableView.separatorColor = UIColor(red: 31/255, green: 31/255, blue: 36/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 31/255, green: 31/255, blue: 36/255, alpha: 1)
        tableView.register(ChannelCell.self, forCellReuseIdentifier: identifier)
        navigationItem.title = "YouTube"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 9/255, green: 9/255, blue: 9/255, alpha: 1)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ChannelCell
        
        cell.video = videos[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.layer.cornerRadius = 18
        cell.clipsToBounds = true
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.systemRed.cgColor
        return cell
    }


}

