//  RecipesCategoriesCollectionCell.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import UIKit

class RecipesCategoriesCollectionCell: UICollectionViewCell {

    @IBOutlet weak var recipesCategoryView : UIView!
    @IBOutlet weak var recipeCategoyImgView : UIImageView!

    @IBOutlet weak var categoryImg : UIImageView!
    @IBOutlet weak var aboutCategoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipesCategoryView.borderColor = UIColor(hex: "D44435")
        recipesCategoryView.layer.borderWidth = 1
        recipesCategoryView.layer.masksToBounds = true
    }

}
