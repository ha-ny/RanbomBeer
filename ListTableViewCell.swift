//
//  ListTableViewCell.swift
//  RanbomBeer
//
//  Created by 김하은 on 2023/08/09.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    var beerData: BeerData?
    let nullImage_url = URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbnOSHZ%2FbtrLTB8V5DQ%2FnlaUCKg7kzbp7PbVKy63Qk%2Fimg.png")

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerLabel: UILabel!
    
    func setting(){
       
        if let beerImage = beerData?.beerImageUrl{
            beerImageView.kf.setImage(with: beerImage)
        }else{
            beerImageView.kf.setImage(with: nullImage_url)
        }
        
        beerNameLabel.text = beerData?.beerName
        beerLabel.text = beerData?.beerDescription
    }
}
