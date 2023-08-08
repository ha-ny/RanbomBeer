//
//  ListTableViewController.swift
//  RanbomBeer
//
//  Created by 김하은 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct BeerData{
    var beerImageUrl: URL?
    var beerName: String
    var beerDescription: String
}

class ListTableViewController: UITableViewController {

    static let identifier = "ListTableViewController"

    var beerList: [BeerData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.topItem?.title = ""
        title = "맥주 리스트"

        let nib = UINib(nibName: ListTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.rowHeight = 150
        
        beerAPI()
    }

    func beerAPI(){
        let url = "https://api.punkapi.com/v2/beers"
        AF.request(url, method: .get).responseJSON { response in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                
                for item in json.arrayValue{
                    self.beerList.append(BeerData(beerImageUrl: URL(string: item["image_url"].stringValue), beerName: item["name"].stringValue, beerDescription: item["description"].stringValue))
                }
                
                self.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as! ListTableViewCell
        cell.beerData = beerList[indexPath.row]
        cell.setting()
        return cell
    }
}
