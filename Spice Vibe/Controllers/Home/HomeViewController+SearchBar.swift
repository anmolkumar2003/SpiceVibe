//  HomeViewController+SearchBar.swift
//  Spice Vibe
//  Created by caglobal on 10/03/25.

import Foundation
import UIKit

extension HomeViewController: UISearchBarDelegate{
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        allRecipesViewModel.filterRecipes(searchText: searchText)
        allRecipiesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension UISearchBar {
    func setIconColor(_ color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField,
           let glassIconView = textField.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = color
        }
    }
}

extension UISearchBar {
    func setPlaceholderColor(_ color: UIColor) {
        guard let textField = self.value(forKey: "searchField") as? UITextField,
              let placeholderLabel = textField.value(forKey: "placeholderLabel") as? UILabel else {
            return
        }
        placeholderLabel.textColor = color
    }
}
