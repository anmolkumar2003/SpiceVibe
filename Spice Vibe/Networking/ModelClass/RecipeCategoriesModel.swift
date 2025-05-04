//  RecipeCategoriesModel.swift
//  Spice Vibe
//  Created by mac on 01-03-2025.

import Foundation

// MARK: - RecipeCategories
struct RecipeCategories: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
