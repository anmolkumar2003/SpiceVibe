//  RandomRecipesTableCell.swift
//  Spice Vibe
//  Created by caglobal on 03/03/25.

import UIKit

class RandomRecipesTableCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
  
    @IBOutlet weak var randomRecipesCollectionView: UICollectionView!
    
    var viewModel: RandomRecipesViewModel! {
        didSet {
            randomRecipesCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        randomRecipesCollectionView.register(UINib(nibName: "RecipesCollectionCell", bundle: nil), forCellWithReuseIdentifier: "RecipesCollectionCell")
        randomRecipesCollectionView.delegate = self
        randomRecipesCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of recipes: \(viewModel.numberOfRecipes)")
      return viewModel.numberOfRecipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let randomRecipesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCollectionCell", for: indexPath) as!
        RecipesCollectionCell
        let randomRecipes = viewModel.randomRecipe(at: indexPath.item)
        let imgUrl = URL(string: randomRecipes.image)
        randomRecipesCell.ourRecipesImgView.sd_setImage(with: imgUrl)
        
        randomRecipesCell.ourRecipesLbl.text = randomRecipes.name
        randomRecipesCell.ourRecipesDescriptionLbl.text = "\(randomRecipes.cookTimeMinutes) minutes"
        return randomRecipesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

