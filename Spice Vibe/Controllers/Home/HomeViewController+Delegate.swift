//  HomeViewController+Delegate.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import Foundation
import UIKit
import SDWebImage

extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allRecipesViewModel.numberOfRecipes)
        return allRecipesViewModel.numberOfRecipes + 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableCell(withIdentifier: "RandomRecipesTableCell") as? RandomRecipesTableCell else {
            return nil
        }
        headerView.backgroundColor = .clear
        headerView.viewModel = randomRecipesViewModel
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Cell 0 – Categories
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableCell", for: indexPath) as! CategoriesTableCell
            cell.viewModel = categoriesViewModel
            return cell
        }

        // Cell 1 – Common Header or Recipe Types
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCommonTableCell", for: indexPath) as! RecipesCommonTableCell
            return cell
        }

        // From row 2 onwards – Recipe Cells
        let recipeIndex = indexPath.row - 2
        let totalRecipes = allRecipesViewModel.numberOfRecipes

        // ✅ SAFETY GUARD
        guard recipeIndex >= 0 && recipeIndex < totalRecipes else {
            print("❌ Out of bounds! recipeIndex: \(recipeIndex), total: \(totalRecipes)")
            return UITableViewCell()
        }

        let recipe = allRecipesViewModel.allRecipe(at: recipeIndex)

        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularRecipesTableCell", for: indexPath) as! PopularRecipesTableCell

        // Assign data safely
        if let imageUrl = URL(string: recipe.image) {
            cell.recipeImage.sd_setImage(with: imageUrl)
        }
        cell.recipeNameLbl.text = recipe.name
        cell.cuisineLbl.text = recipe.cuisine
        cell.RatingLbl.text = "★★★★☆ \(recipe.rating)"
        cell.sizeLbl.text = "\(recipe.difficulty)"

        return cell
    }



//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if indexPath.row == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableCell", for: indexPath) as! CategoriesTableCell
//            // Pass the ViewModel data to the CategoriesTableCell
//            cell.viewModel = categoriesViewModel  // Set the ViewModel
//            cell.categoriesCollectionView.reloadData() // Reload collection view after setting data
//            return cell
//            
//        }
//        else if indexPath.row == 1{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCommonTableCell", for: indexPath) as! RecipesCommonTableCell
//            cell.contentView.backgroundColor = .yellow
//            return cell
//            
//        }
//        else /*if indexPath.row == 2*/{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularRecipesTableCell", for: indexPath) as! PopularRecipesTableCell
//            let allRecipes = allRecipesViewModel.allRecipe(at: indexPath.item)
//            let recipeImgUrl = URL(string: allRecipes.image)
//            cell.recipeImage.sd_setImage(with: recipeImgUrl)
//            cell.RatingLbl.text = "★★★★☆\(allRecipes.rating)"
//            cell.cuisineLbl.text = allRecipes.cuisine
//            cell.recipeNameLbl.text = allRecipes.name
//            cell.sizeLbl.text = "\(allRecipes.difficulty)"
//            return cell
//        }
//        return UITableViewCell()
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = allRecipesViewModel.allRecipe(at: indexPath.row)
        
        let vc = SpiceVibeStoryBoards.viewController(from: .DetailedRecipe, ofType: DetailedRecipeViewController.self)
        vc.recipe = recipe
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 160
        }else if indexPath.row == 1{
            return 30
        }
        return 160
    }
    
    @objc func viewAllDetailsBtn(sender: UIButton){
        let vc = SpiceVibeStoryBoards.viewController(from: .DetailedRecipe, ofType: DetailedRecipeViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
