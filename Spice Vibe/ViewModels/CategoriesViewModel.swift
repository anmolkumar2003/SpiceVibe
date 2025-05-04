//  CategoriesViewModel.swift
//  Spice Vibe
//  Created by mac on 01-03-2025.

import Foundation
import UIKit

class CategoriesViewModel {
    
    private var categories: [Category] = []
    // Closure (callback) to notify the view that data has been updated
    var categoriesUpdated: (() -> Void)?
    
    var numberOfCategories: Int {
        return categories.count
    }
    
    init() {
         // Observe internet restoration to retry API calls
         NotificationCenter.default.addObserver(self, selector: #selector(retryApiCall), name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
     }
    
    func category(at index: Int) -> Category {
        return categories[index]
    }
    
    // Fetch Categories and notify the view
    func fetchCategories() {
        ApiManager().fetchMealCategories { [weak self] categories,error  in
            DispatchQueue.main.async {
                        if let error = error{
                ApiError.handleApiErrors(error: error)
            } else{
                self?.categories = categories!
                self?.categoriesUpdated?() // Notify view that categories are updated
            }
        }
        }
    }
    
    @objc func retryApiCall(){
        fetchCategories()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
    }
}
