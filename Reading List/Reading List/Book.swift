//
//  Book.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_167 on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    let hasbeenRead: Bool = false
    
    init (title: String, reasonToRead: String, hasbeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = title
}
    
}
