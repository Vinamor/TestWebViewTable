//
//  Post.swift
//  TestWebViewTable
//
//  Created by Ostap Romaniv on 3/21/17.
//  Copyright © 2017 Ostap Romaniv. All rights reserved.
//

import UIKit

class Post {
    let author: String?
    let title: String?
    let description: String?
    let myUrl: String?
    let imageStr: String?
    let publishingDate: String?
    
    init(author: String? = nil, title: String? = nil, description: String? = nil, myUrl: String? = nil, imageStr: String? = nil, publishingDate: String? = nil) {
        self.author = author
        self.title = title
        self.description = description
        self.myUrl = myUrl
        self.imageStr = imageStr
        self.publishingDate = publishingDate
    }
}
