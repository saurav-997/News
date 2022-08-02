//
//  NewsDataModel.swift
//  News
//
//  Created by Saurav Sharma on 01/08/22.
//

import Foundation

struct NewsDataModel: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
}
struct Articles: Decodable
{
    var author :String
    var title :String
    var description :String
    var url :String
    var urlToImage :String
}
