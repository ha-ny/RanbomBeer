//
//  RandomViewController.swift
//  RanbomBeer
//
//  Created by 김하은 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class RandomViewController: UIViewController {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDescriptionLabel: UITextView!
    @IBOutlet var randomButton: UIButton!
    
    let nullImage_url = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbnOSHZ%2FbtrLTB8V5DQ%2FnlaUCKg7kzbp7PbVKy63Qk%2Fimg.png")
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonClick))
        navigationItem.rightBarButtonItem?.tintColor = .darkGray

        randomButton.layer.cornerRadius = 8
        randomButton.tintColor = .black
        randomButton.layer.borderColor = UIColor.darkGray.cgColor
        randomButton.layer.borderWidth = 0.5
        ranbomButtonClick(randomButton)
    }

    @objc func listButtonClick(){
        let vc = storyboard?.instantiateViewController(identifier: ListTableViewController.identifier) as! ListTableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func beerAPI(){
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).responseJSON { response in
            switch response.result{
            case.success(let value):
                let json = JSON(value)[0]
                
                
                let image_url = URL(string: json["image_url"].stringValue)

                if let image_url{
                    self.beerImageView.kf.setImage(with: image_url)
                }else{
                    self.beerImageView.kf.setImage(with: self.nullImage_url)
                }
                self.beerNameLabel.text = json["name"].stringValue
                self.beerDescriptionLabel.text = json["description"].stringValue

            case.failure(let error):
                print(error)
            }
        }
    }

    @IBAction func ranbomButtonClick(_ sender: UIButton) {
        beerAPI()
    }
}

