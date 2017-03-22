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
    
    var PostsArray = [Post]()
    
    // Функція, яка бере урлу і завантажує JSON
    func downLoadJSONWithURL() {
        let url = NSURL(string: "https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=89409e6a3a5c4400926e6cb5c424241f")
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObject!.value(forKey: "articles")!)
                
                if let articleArray = jsonObject!.value(forKey: "articles") as? NSArray {
                    for article in articleArray {
                        if let articleDict = article as? NSDictionary {
                            
                            let authorStr: String = {
                                if let author = articleDict.value(forKey: "author") {
                                    return author as! String
                                }
                                return "Unknown author"
                            }()
                            
                            let titleStr: String = {
                                if let title = articleDict.value(forKey: "title") {
                                    return title as! String
                                }
                                return "Unknown title"
                            }()
                            
                            let descriptionStr: String = {
                                if let description = articleDict.value(forKey: "description") {
                                    return description as! String
                                }
                                return "Unknown description"
                            }()
                            
                            let myUrlStr: String = {
                                if let myUrl = articleDict.value(forKey: "url") {
                                    return myUrl as! String
                                }
                                return "Unknown url"
                            }()
                            
                            let imageStr: String = {
                                if let image = articleDict.value(forKey: "urlToImage") {
                                    return image as! String
                                }
                                return "Unknown Image"
                            }()
                            
                            
//                            let publishingDateStr: String = {
//                                if let publishingDate = articleDict.value(forKey: "publishedAt") {
//                                    return publishingDate as! String
//                                }
//                                return "Unknown date"
//                            }()
//                            
                            self.PostsArray.append(Post(author: authorStr, title: titleStr, description: descriptionStr, myUrl: myUrlStr, imageStr: imageStr))
                            
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
        let url = NSURL(string: "https://newsapi.org/v1/articles?source=bbc-sport&sortBy=top&apiKey=89409e6a3a5c4400926e6cb5c424241f")
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(jsonData!)
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downLoadJSONWithURL()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        // #warning Incomplete implementation, return the number of rows
        //        var returnCountOfRows = 0
        //
        //        switch(segmentControl.selectedSegmentIndex) {
        //        case 0:
        //
        //        case 1:
        //
        //        case 2:
        //
        //        default:
        //        }
        //
        return PostsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        // tableView.register(UINib(nibName: "WebViewTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        // tableView.register(WebViewTableViewCell.self, forCellReuseIdentifier: "newsCell")
        
        let post = PostsArray[indexPath.row]
        
        cell.contentTitleLabel.text = post.title
        cell.contentDescriptionLabel.text = post.description
        cell.authorLabel.text = post.author
        cell.dateOfPublishing.text = post.publishingDate
        
        let imageURL = NSURL(string: post.imageStr!)
        
        if imageURL != nil {
            let data = NSData(contentsOf: (imageURL as? URL)!)
            
            cell.contentImageView.image = UIImage(data: data as! Data)
            cell.contentImageView.layer.cornerRadius = 0.5 * cell.contentImageView.frame.size.width
            cell.contentImageView.layer.borderColor = UIColor.darkGray.cgColor
            cell.contentImageView.layer.borderWidth = 2.0
            cell.contentImageView.clipsToBounds = true
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "showDetail" {
            let postDetailViewController = segue.destination as! PostViewController
            
            if let selectedPostCell = sender as? NewsTableViewCell {
                let indexPath = tableView.indexPath(for: selectedPostCell)!
                let selectedPost = PostsArray[indexPath.row]
                postDetailViewController.post = selectedPost
            } else {
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            }
        }
    }
    
//    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? PostViewController, let meal = sourceViewController.post {
//            
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                // Update an existing meal.
//                PostsArray[selectedIndexPath.row] = meal
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            }
//         
//        }
//    }
}
