//  AllRecipesViewModel.swift
//  Spice Vibe
//  Created by anmol on 04/03/25.

import Foundation
import UIKit

class AllRecipesViewModel {
    private var allRecipes: [Recipe] = []
    private var filteredRecipes: [Recipe] = []
    private var hasUpdated = false
    
    var isFiltering: Bool = false
    
    var allRecipesUpdated: (() -> Void)?
    var numberOfRecipes: Int {
        return isFiltering ? filteredRecipes.count : allRecipes.count
    }
    
    func allRecipe(at index: Int) -> Recipe {
        return isFiltering ? filteredRecipes[index] : allRecipes[index]
    }
    
    func filterRecipes(searchText: String) {
        if searchText.isEmpty {
            isFiltering = false
        } else {
            isFiltering = true
            filteredRecipes = allRecipes.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
            if filteredRecipes.isEmpty{
                let view = UIView()
                let label = UILabel()
                view.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
                view.addSubview(label)
                view.backgroundColor = .orange
                label.text = "No Result Found."
            }
        }
        allRecipesUpdated?() // Reload trigger
    }
    
    func fetchAllRecipes() {
        ApiManager().fetchRecipesResponse { [weak self] recipes, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    ApiError.handleApiErrors(error: error)
                    self.allRecipesUpdated?()
                    return
                }
                
                if let fetchedRecipes = recipes {
                    self.allRecipes = fetchedRecipes
                    self.filteredRecipes = fetchedRecipes
                }
                
                self.allRecipesUpdated?()
            }
        }
    }
    
}
