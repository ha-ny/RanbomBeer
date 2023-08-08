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

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerLabel: UILabel!
    
    func setting(){
        beerImageView.kf.setImage(with: beerData?.beerImageUrl)
        beerNameLabel.text = beerData?.beerName
        beerLabel.text = beerData?.beerDescription
    }
}
