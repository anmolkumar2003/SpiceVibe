//  CategoriesTableCell.swift
//  Spice Vibe
//  Created by mac on 01-03-2025.

import UIKit

class CategoriesTableCell: UITableViewCell {
    
    @IBOutlet weak var categoriesCollectionView : UICollectionView!
    // Reference to ViewModel
       var viewModel: CategoriesViewModel! {
           didSet {
               categoriesCollectionView.reloadData()
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoriesCollectionView.register(UINib(nibName: "RecipesCategoriesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "RecipesCategoriesCollectionCell")
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
}

extension CategoriesTableCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCategoriesCollectionCell", for: indexPath) as! RecipesCategoriesCollectionCell
        let category = viewModel.category(at: indexPath.item) // Get category from ViewModel
        let imageUrl = URL(string: category.strCategoryThumb)
        categoryCell.categoryImg.sd_setImage(with: imageUrl)
        categoryCell.aboutCategoryLbl.text = category.strCategory
        return categoryCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.0, height: collectionView.frame.height)
    }
}
