//
//  ViewController.swift
//  RanbomBeer
//
//  Created by 김하은 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerDescriptionLabel: UITextView!
    @IBOutlet var randomButton: UIButton!
    
    let nullImage_url = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbnOSHZ%2FbtrLTB8V5DQ%2FnlaUCKg7kzbp7PbVKy63Qk%2Fimg.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomButton.layer.cornerRadius = 8
        randomButton.tintColor = .black
        randomButton.layer.borderColor = UIColor.darkGray.cgColor
        randomButton.layer.borderWidth = 0.5
        ranbomButtonClick(randomButton)
    }

    func beerAPI(){
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).responseJSON { response in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                
                let image_url = URL(string: json[0]["image_url"].stringValue)

                if let image_url{
                    self.beerImageView.kf.setImage(with: image_url)
                }else{
                    self.beerImageView.kf.setImage(with: self.nullImage_url)
                }
                self.beerNameLabel.text = json[0]["name"].stringValue
                self.beerDescriptionLabel.text = json[0]["description"].stringValue

            case.failure(let error):
                print(error)
            }
        }
    }

    @IBAction func ranbomButtonClick(_ sender: UIButton) {
        beerAPI()
    }
}

