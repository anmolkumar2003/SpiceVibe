//  PopularRecipesTableCell.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import UIKit

class PopularRecipesTableCell: UITableViewCell {
    @IBOutlet weak var cuisineLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var RatingLbl: UILabel!
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var viewAllDetailsBtn: UIButton!
    @IBOutlet weak var popularRecipesView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
