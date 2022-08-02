//
//  ViewController.swift
//  News
//
//  Created by Saurav Sharma on 01/08/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController
{
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainVCActivityIndicator: UIActivityIndicatorView!
    
    var newsObj = NewsController()
    var newsURL: URL?
    var newsTitle: String?
    var refreshControl = UIRefreshControl()
    var newsData = [NewsModel]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mainVCActivityIndicator.isHidden = false
        self.view.bringSubviewToFront(mainVCActivityIndicator)
        newsObj.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customNewsCell")
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 300
        mainTableView.separatorStyle = .none
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching news...")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        mainTableView.refreshControl = refreshControl
        
        newsObj.callAPI()
    }
    
    @objc func refreshTableView(){
        refreshControl.endRefreshing()
        newsObj.callAPI()
    }
    deinit {
        newsData.removeAll()
        newsURL = nil
    }
}

extension ViewController: NewsDelegate {
    func getNewsData(model: [NewsModel]) {
        newsData = model
        DispatchQueue.main.async {
            self.mainVCActivityIndicator.isHidden = true
            self.mainTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customNewsCell", for: indexPath) as! CustomTableViewCell
        let url = URL(string: newsData[indexPath.row].urlToImage)
       
        cell.newsImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.25))], progressBlock: nil)
        

        DispatchQueue.main.async {
            cell.titleLabel.text = self.newsData[indexPath.row].title
            cell.descriptionLabel.text = self.newsData[indexPath.row].description
            cell.authorLabel.text = self.newsData[indexPath.row].author
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        newsURL = URL(string: newsData[indexPath.row].url)
        newsTitle = newsData[indexPath.row].title
        performSegue(withIdentifier: "showWebView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webVC = segue.destination as? WebViewController
        webVC?.myURL = newsURL
        webVC?.newsTitle = newsTitle
    }
}

