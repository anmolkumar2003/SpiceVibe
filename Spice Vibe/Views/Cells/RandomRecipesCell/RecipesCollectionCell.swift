//  RecipiesCollectionCell.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import UIKit
import CollectionViewPagingLayout
class RecipesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var ourRecipesLbl: UILabel!
    @IBOutlet weak var ourRecipesDescriptionLbl: UILabel!
    @IBOutlet weak var ourRecipesImgView: UIImageView!
    @IBOutlet weak var ourRecipiesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRecipesCollectionCell()
    }
    
    func setRecipesCollectionCell(){
        ourRecipesImgView.layer.masksToBounds = true
        ourRecipiesView.layer.cornerRadius = 10
        ourRecipiesView.layer.masksToBounds = true
    }
}
