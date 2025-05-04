////  AllRecipesViewModel.swift
////  Spice Vibe
////  Created by caglobal on 04/03/25.
//
import Foundation
import UIKit
//class AllRecipesViewModel {
//    
//    private var allRecipes: [Recipe] = []  // Store all fetched recipes
//    private var setfilteredRecipes: [Recipe] = [] // Store filtered recipes
//    var allRecipesUpdated: (() -> Void)?  // Callback for UI updates
//    var isFiltering: Bool = false
////    var numberOfRecipes: Int {
////        print(allRecipes.count)
////        //return allRecipes.count
////        return setfilteredRecipes.count
////    }
//    
//    var numberOfRecipes: Int {
//         return isFiltering ? setfilteredRecipes.count : allRecipes.count
//     }
//    init() {
//        // Observe internet restoration to retry API calls
//        NotificationCenter.default.addObserver(self, selector: #selector(retryApiCall), name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
//    }
//    
////    func allRecipe(at index: Int) -> Recipe {
////        //return allRecipes[index]
////        return isFiltering ? setfilteredRecipes[index] : allRecipes[index]
////    }
//    
//    func allRecipe(at index: Int) -> Recipe {
//        if index >= (isFiltering ? setfilteredRecipes.count : allRecipes.count) {
//            fatalError("💥 Crash: allRecipe(at: \(index)) out of bounds!")
//        }
//        return isFiltering ? setfilteredRecipes[index] : allRecipes[index]
//    }
//
//    func fetchAllRecipes() {
//        ApiManager().fetchRecipesResponse { [weak self] recipes,error  in
//            guard let self = self, let fetchedRecipes = recipes else { return }
//            DispatchQueue.main.async {
//                if let error = error{
//                    ApiError.handleApiErrors(error: error)
//                } else{
//                    self.allRecipes = fetchedRecipes  // Store all recipes
//                    self.setfilteredRecipes = fetchedRecipes
//                    print("filter recipes",self.setfilteredRecipes)
//                    self.allRecipesUpdated?()  // Notify view that data is updated
//                }
//            }
//        }
//    }
//    
////    func searchRecipes(with query: String) {
////        if query.isEmpty {
////            setfilteredRecipes = allRecipes
////        } else {
////            setfilteredRecipes = allRecipes.filter {
////                $0.name.lowercased().contains(query.lowercased()) ?? false
////            }
////        }
////        allRecipesUpdated?()
////    }
//    
//    func filterRecipes(searchText: String) {
//         isFiltering = !searchText.isEmpty
//        setfilteredRecipes = allRecipes.filter { recipe in
//             return recipe.name.lowercased().contains(searchText.lowercased())
//         }
//         allRecipesUpdated?()
//     }
//    
//    @objc func retryApiCall(){
//        fetchAllRecipes()
//    }
//    
//    deinit{
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
//    }
//}


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


//    func fetchAllRecipes() {
//        ApiManager().fetchRecipesResponse { [weak self] recipes, error in
//            guard let self = self, let fetchedRecipes = recipes else { return }
//            DispatchQueue.main.async {
//                if let error = error {
//                    ApiError.handleApiErrors(error: error)
//                } else {
//                    self.allRecipes = fetchedRecipes
//                    self.filteredRecipes = fetchedRecipes // default same
//                    self.allRecipesUpdated?()
//                }
//            }
//        }
//    }
    
    func fetchAllRecipes() {
        ApiManager().fetchRecipesResponse { [weak self] recipes, error in
            guard let self = self, let fetchedRecipes = recipes else { return }
            DispatchQueue.main.async {
                if let error = error {
                    ApiError.handleApiErrors(error: error)
                } else {
                    self.allRecipes = fetchedRecipes
                    self.filteredRecipes = fetchedRecipes
                    if !self.hasUpdated {
                        self.hasUpdated = true
                        self.allRecipesUpdated?()
                    }
                }
            }
        }
    }

}
