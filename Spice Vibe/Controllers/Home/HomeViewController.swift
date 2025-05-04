//  HomeViewController.swift
//  Spice Vibe
//  Created by caglobal on 20/02/25.

import UIKit
import Alamofire
import SDWebImage
import CollectionViewPagingLayout
import RAMAnimatedTabBarController
import Lottie

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var allRecipiesTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - ViewModel Variables
    
    var categoriesViewModel = CategoriesViewModel()
    var randomRecipesViewModel = RandomRecipesViewModel()
    var allRecipesViewModel = AllRecipesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        registerTableAndCollectionCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apis()
    }
    
    @IBAction func menuBtn(_ sender: Any) {
        //        if let menuContainer = self.parent as? MenuContainerView {
        //            menuContainer.showSideMenu()
        //        } else {
        //            print("❌ Error: HomeViewController is not inside MenuContainerView")
        //        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.searchBarView.isHidden = true
        searchButton.isHidden = false
        menuBtn.isHidden = false
        self.searchButton.alpha = 1
        resignFirstResponder()
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        searchBarView.alpha = 0
        searchBarView.isHidden = false
        searchBar.setIconColor(.darkGray)
        searchBar.setPlaceholderColor(.darkGray)
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut, animations: {
            self.searchBarView.alpha = 1
            self.searchButton.alpha = 0
        }) { _ in
            self.searchButton.isHidden = true
            self.menuBtn.isHidden = true
        }
    }
    
    // MARK: -  Register Table And CollectionCells
    func showLoader(){
        LoaderManager.shared.showLoader(on: self.view)
    }
    
    func hideLoader(){
        LoaderManager.shared.hideLoader()
    }

//    func apis(){
//       
//        showLoader()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//        let dispatchGroup = DispatchGroup()
//        dispatchGroup.enter()
//            self.categoriesViewModel.categoriesUpdated = { [weak self] in
//            self?.relaodTableView()
//            dispatchGroup.leave()
//        }
//        
//        // Fetch categories from the ViewModel
//            self.categoriesViewModel.fetchCategories()
//            
//            dispatchGroup.enter()
//            self.randomRecipesViewModel.randomRecipesUpdated = {
//            [weak self] in
//            self?.relaodTableView()
//                dispatchGroup.leave()
//
//        }
//            dispatchGroup.enter()
//            self.randomRecipesViewModel.fetchRandomRecipes()
//            self.allRecipesViewModel.allRecipesUpdated = {
//            [weak self] in
//            self?.relaodTableView()
//                dispatchGroup.leave()
//                Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
//        }
//            self.allRecipesViewModel.fetchAllRecipes()
//        
//        dispatchGroup.notify(queue: .main) { [weak self] in
//                self?.hideLoader()
//            }
//        })
//    }
    
    func apis() {
        print("🔄 Starting API calls")
        //showLoader()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let dispatchGroup = DispatchGroup()

            // Categories
            dispatchGroup.enter()
            print("📡 Fetching Categories...")
            self.categoriesViewModel.categoriesUpdated = { [weak self] in
                print("✅ Categories callback received")
                defer {
                    print("➡️ Leaving dispatch group for Categories")
                    dispatchGroup.leave()
                }
                self?.reloadTableView()
            }
            self.categoriesViewModel.fetchCategories()

            // Random Recipes
            dispatchGroup.enter()
            print("📡 Fetching Random Recipes...")
            self.randomRecipesViewModel.randomRecipesUpdated = { [weak self] in
                print("✅ Random Recipes callback received")
                defer {
                    print("➡️ Leaving dispatch group for Random Recipes")
                    dispatchGroup.leave()
                }
                self?.reloadTableView()
            }
            self.randomRecipesViewModel.fetchRandomRecipes()

            // All Recipes
            dispatchGroup.enter()
            print("📡 Fetching All Recipes...")
            // Set closures before calling fetch to avoid missed callback
            self.allRecipesViewModel.allRecipesUpdated = { [weak self] in
                print("✅ All Recipes callback received")
                defer {
                    print("➡️ Leaving dispatch group for All Recipes")
                  //  dispatchGroup.leave()
                }
                self?.reloadTableView()
            }

            self.allRecipesViewModel.fetchAllRecipes()

            dispatchGroup.notify(queue: .main) { [weak self] in
                print("🎉 All API calls completed. Hiding loader.")
                self?.hideLoader()
            }
        }
    }


    
//    func reloadTableView(){
//        self.allRecipiesTableView.reloadData()
//    }
    
    func reloadTableView() {
        print("📦 Reloading TableView...")

        guard let tableView = self.allRecipiesTableView else {
            print("❌ tableView is nil!")
            return
        }

        print("✅ TableView exists. Reloading...")
        tableView.reloadData()
    }

    
    func registerTableAndCollectionCells() {
        let tableCells = [ "RecipesCommonTableCell", "PopularRecipesTableCell","RandomRecipesTableCell","CategoriesTableCell"]
        
        let collectionCells = ["RecipesCollectionCell", "RecipesCategoriesCollectionCell"]
        tableCells.forEach { cell in
            allRecipiesTableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        }
        allRecipiesTableView.delegate = self
        allRecipiesTableView.dataSource = self
    }
}

//MARK: - Extension of UIColor Code

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

