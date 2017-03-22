//
//  PostViewController.swift
//  TestWebViewTable
//
//  Created by Ostap Romaniv on 3/21/17.
//  Copyright © 2017 Ostap Romaniv. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var myWebView: UIWebView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        
        if let url = URL(string: (post?.myUrl)!) {
            let request = URLRequest(url: url)
            myWebView.loadRequest(request)
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

