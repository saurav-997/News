//
//  NewsController.swift
//  News
//
//  Created by Saurav Sharma on 01/08/22.
//

import Foundation

protocol NewsDelegate{
    func getNewsData(model:[NewsModel])
}
class NewsController {
    var delegate: NewsDelegate?
    func callAPI()
    {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=715c5eb6b2894ec0ae74a201880b9dd4")! //force unwrapping beacuse we know url is correct
        let sessionTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                do {
                    let decoder = JSONDecoder()
                    let newData = try decoder.decode(NewsDataModel.self, from: data)
                    var newsData = [NewsModel]()
                    for i in 0..<(newData.totalResults) {
                        newsData.append(NewsModel(author: newData.articles[i].author, title: newData.articles[i].title, description: newData.articles[i].description, url: newData.articles[i].url, urlToImage: newData.articles[i].urlToImage))
                    }
                    self.delegate?.getNewsData(model: newsData)
                    
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        sessionTask.resume()
    }
}
