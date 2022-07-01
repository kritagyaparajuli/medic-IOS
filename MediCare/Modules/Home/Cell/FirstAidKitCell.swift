//
//  FirstAidKitCell.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/30/22.
//

import UIKit

class FirstAidKitCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var imgFirstAidKit: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        // Initialization code
    }
    
    func configureButton(){
        btnAddToCart.isAddToCartButton(title: "ADD TO CART")
    }

}
