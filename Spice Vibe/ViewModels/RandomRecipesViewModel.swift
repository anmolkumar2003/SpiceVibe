//  RandomRecipesViewModel.swift
//  Spice Vibe
//  Created by caglobal on 04/03/25.

import Foundation
import UIKit

class RandomRecipesViewModel {
    
    private var allRecipes: [Recipe] = []  // Store all fetched recipes
    private(set) var randomRecipes: [Recipe] = [] // Only store 10 random recipes
    
    var randomRecipesUpdated: (() -> Void)?  // Callback for UI updates
    var numberOfRecipes: Int {
        return randomRecipes.count
    }
    init() {
          // Observe internet restoration to retry API calls
        NotificationCenter.default.addObserver(self, selector: #selector(retryApiCall), name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
      }
    
    func randomRecipe(at index: Int) -> Recipe {
        return randomRecipes[index]
    }
    
    func fetchRandomRecipes() {
        ApiManager().fetchRecipesResponse { [weak self] recipes,error  in
            guard let self = self, let fetchedRecipes = recipes else { return }
            DispatchQueue.main.async {
                if let error = error {
                    ApiError.handleApiErrors(error:error)
                } else{
                    self.allRecipes = fetchedRecipes  // Store all recipes
                    
                    // Pick 10 random recipes
                    self.randomRecipes = Array(fetchedRecipes.shuffled().prefix(10))
                    
                    print("Loaded \(self.randomRecipes.count) random recipes")
                    self.randomRecipesUpdated?()  // Notify view that data is updated
                }
            }
        }
    }
    
    @objc func retryApiCall(){
        fetchRandomRecipes()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
    }
}
