//
//  WebViewTableViewController.swift
//  TestWebViewTable
//
//  Created by Ostap Romaniv on 3/21/17.
//  Copyright © 2017 Ostap Romaniv. All rights reserved.
//

import UIKit
import os.log

class WebViewTableViewController: UITableViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var PostsArray = [Post?]()
    var PostsArray2 = [Post?]()
    // Функція, яка бере урлу і завантажує JSON
    func downloadJSONWithURL() {
        let url = NSURL(string: "https://newsapi.org/v1/articles?source=talksport&sortBy=top&apiKey=89409e6a3a5c4400926e6cb5c424241f")
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObject!.value(forKey: "articles")!)
                
                if let articleArray = jsonObject!.value(forKey: "articles") as? NSArray {
                    for article in articleArray {
                        if let articleDict = article as? NSDictionary {
                            
                            let authorStr: String? = {
                                if let author = articleDict.value(forKey: "author") {
                                    return (author as? String)
                                }
                                return "Unknown Author"
                            }()
                            
                            let titleStr: String? = {
                                if let title = articleDict.value(forKey: "title") {
                                    return (title as? String)
                                }
                                return "Unknown Title"
                            }()
                            
                            let descriptionStr: String? = {
                                if let description = articleDict.value(forKey: "description") {
                                    return (description as? String)
                                }
                                return "Unknown Description"
                            }()
                            
                            let myUrlStr: String? = {
                                if let myUrl = articleDict.value(forKey: "url") {
                                    return (myUrl as? String)
                                }
                                return "Unknown URL"
                            }()
                            
                            let imageStr: String? = {
                                if let urlToImage = articleDict.value(forKey: "urlToImage") {
                                    return (urlToImage as? String)
                                }
                                return "Unknown Image"
                            }()
                            
                            
                            let publishingDateStr: String? = {
                                if let publishingDate = articleDict.value(forKey: "publishedAt") {
                                    return (publishingDate as? String)
                                }
                                return "Unknown Date"
                            }()
                            
                            self.PostsArray.append(Post(author: authorStr, title: titleStr, description: descriptionStr, myUrl: myUrlStr, imageStr: imageStr, publishingDate: publishingDateStr))
                            
                            OperationQueue.main.addOperation {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }).resume()
    }
    
    func downloadJSONWithURL2() {
        let url2 = NSURL(string: "https://newsapi.org/v1/articles?source=talksport&sortBy=latest&apiKey=89409e6a3a5c4400926e6cb5c424241f")
        URLSession.shared.dataTask(with: (url2 as? URL)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObject!.value(forKey: "articles")!)
                
                if let articleArray = jsonObject!.value(forKey: "articles") as? NSArray {
                    for article in articleArray {
                        if let articleDict = article as? NSDictionary {
                            
                            let authorStr: String? = {
                                if let author = articleDict.value(forKey: "author") {
                                    return (author as? String)
                                }
                                return "Unknown Author"
                            }()
                            
                            let titleStr: String? = {
                                if let title = articleDict.value(forKey: "title") {
                                    return (title as? String)
                                }
                                return "Unknown Title"
                            }()
                            
                            let descriptionStr: String? = {
                                if let description = articleDict.value(forKey: "description") {
                                    return (description as? String)
                                }
                                return "Unknown Description"
                            }()
                            
                            let myUrlStr: String? = {
                                if let myUrl = articleDict.value(forKey: "url") {
                                    return (myUrl as? String)
                                }
                                return "Unknown URL"
                            }()
                            
                            let imageStr: String? = {
                                if let urlToImage = articleDict.value(forKey: "urlToImage") {
                                    return (urlToImage as? String)
                                }
                                return "Unknown Image"
                            }()
                            
                            let publishingDateStr: String? = {
                                if let publishingDate = articleDict.value(forKey: "publishedAt") {
                                    return (publishingDate as? String)
                                }
                                return "Unknown Date"
                            }()
                            
                            self.PostsArray2.append(Post(author: authorStr, title: titleStr, description: descriptionStr, myUrl: myUrlStr, imageStr: imageStr, publishingDate: publishingDateStr))
                            
                            OperationQueue.main.addOperation {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }).resume()
    }

    // Інший спосіб отримати JSON
    func downloadJSONWithTask() {
        let url = NSURL(string: "https://newsapi.org/v1/articles?source=sky-sports-news&sortBy=top&apiKey=89409e6a3a5c4400926e6cb5c424241f")
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(jsonData!)
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJSONWithURL()
        self.downloadJSONWithURL2()
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        
        switch(segmentControl.selectedSegmentIndex) {
        case 0: if(PostsArray.count == 0) {
            self.downloadJSONWithURL()
            self.tableView.reloadData()
        }         case 1: if(PostsArray2.count == 0) {
            self.downloadJSONWithURL2()
            self.tableView.reloadData()
        }
        default:
            break
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //#warning Incomplete implementation, return the number of rows
                var returnCountOfRows = 0
        
                switch(segmentControl.selectedSegmentIndex) {
                case 0:
                    returnCountOfRows = PostsArray.count
                case 1:
                    returnCountOfRows = PostsArray2.count
                default:
                    break
                }
        
        return returnCountOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        switch (segmentControl.selectedSegmentIndex) {
        case 0:
            let post = PostsArray[indexPath.row]
            cell.contentTitleLabel.text = post?.title
            cell.contentDescriptionLabel.text = post?.description
            cell.authorLabel.text = post?.author
            cell.dateOfPublishing.text = post?.publishingDate
            
            if let imageURL = NSURL(string: (post?.imageStr)!) {
                let data = NSData(contentsOf: (imageURL as URL))
                cell.contentImageView.image = UIImage(data: data as! Data)
                cell.contentImageView.layer.cornerRadius = 0.5 * cell.contentImageView.frame.size.width
                cell.contentImageView.layer.borderColor = UIColor.darkGray.cgColor
                cell.contentImageView.layer.borderWidth = 2.0
                cell.contentImageView.clipsToBounds = true
            }
            
        case 1:
            let post2 = PostsArray2[indexPath.row]
            cell.contentTitleLabel.text = post2?.title
            cell.contentDescriptionLabel.text = post2?.description
            cell.authorLabel.text = post2?.author
            cell.dateOfPublishing.text = post2?.publishingDate
            
            
            if let imageURL = NSURL(string: (post2?.imageStr)!) {
                let data = NSData(contentsOf: (imageURL as URL))
                cell.contentImageView.image = UIImage(data: data as! Data)
                cell.contentImageView.layer.cornerRadius = 0.5 * cell.contentImageView.frame.size.width
                cell.contentImageView.layer.borderColor = UIColor.darkGray.cgColor
                cell.contentImageView.layer.borderWidth = 2.0
                cell.contentImageView.clipsToBounds = true
            }
        default:
            break
        }
        
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetail" {
            let selectedPost: Post?
            if let postDetailViewController = segue.destination as? PostViewController {
                if let selectedPostCell = sender as? NewsTableViewCell {
                    let indexPath = tableView.indexPath(for: selectedPostCell)!
                    
                    switch (segmentControl.selectedSegmentIndex) {
                    case 0:
                        selectedPost = PostsArray[indexPath.row]
                    case 1: selectedPost = PostsArray2[indexPath.row]
                    default:
                        fatalError("Unexpected Segue Identifier; \(segue.identifier)")
                    }
                    postDetailViewController.post = selectedPost
                }
            }
        }
    }
}
