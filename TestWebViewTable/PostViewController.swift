//
//  PostViewController.swift
//  TestWebViewTable
//
//  Created by Ostap Romaniv on 3/21/17.
//  Copyright © 2017 Ostap Romaniv. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var myWebView: UIWebView!
    
    var post: Post?
    
//    @IBAction func cancelThePost(_ sender: UIBarButtonItem) {
//        dismiss(animated: true, completion: nil)
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post, let _ = post.author, let _ = post.title, let _ = post.description, let myUrl = post.myUrl, let _ = post.imageStr, let _ = post.publishingDate {
            let url = NSURL(string: myUrl)
            let requestObj = NSURLRequest(url: url as! URL)
            myWebView.loadRequest(requestObj as URLRequest)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myURL = myWebView.request
        post = Post(myUrl: String(describing:myURL))

    }


}

