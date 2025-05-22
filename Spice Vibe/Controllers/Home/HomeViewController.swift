//  HomeViewController.swift
//  Spice Vibe
//  Created by caglobal on 20/02/25.

import UIKit
import Alamofire
import SDWebImage
import CollectionViewPagingLayout
import RAMAnimatedTabBarController
import Lottie
import SkeletonView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var popuar: UILabel!
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
        allRecipiesTableView.keyboardDismissMode = .interactive
        registerTableAndCollectionCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        apis()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)

        allRecipiesTableView.contentInset = contentInsets
        allRecipiesTableView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        allRecipiesTableView.contentInset = contentInsets
        allRecipiesTableView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func menuBtn(_ sender: Any) {
        
        let menuVc = SpiceVibeStoryBoards.viewController(from: .sampleMenuViewController, ofType: SampleMenuViewController.self)
        navigationController?.pushViewController(menuVc, animated: true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.searchBarView.isHidden = true
        searchButton.isHidden = false
        menuBtn.isHidden = false
        self.searchButton.alpha = 1
        searchBar.resignFirstResponder()
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
    
    func apis() {
        //showLoader()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let dispatchGroup = DispatchGroup()
            
            // MARK: - Categories API
            
            dispatchGroup.enter()
            print("Fetching Categories...")
            self.categoriesViewModel.categoriesUpdated = { [weak self] in
                print("Categories callback received")
                defer {
                    print("Leaving dispatch group for Categories")
                    dispatchGroup.leave()
                }
                self?.reloadTableView()
            }
            self.categoriesViewModel.fetchCategories()
            
            // MARK: - Random Recipes API
            
            dispatchGroup.enter()
            print("Fetching Random Recipes...")
            self.randomRecipesViewModel.randomRecipesUpdated = { [weak self] in
                print("Random Recipes callback received")
                defer {
                    print("Leaving dispatch group for Random Recipes")
                    dispatchGroup.leave()
                }
                self?.reloadTableView()
            }
            self.randomRecipesViewModel.fetchRandomRecipes()
            
            // MARK: - All Recipes API
            
            dispatchGroup.enter()
            print("Fetching All Recipes...")
            self.allRecipesViewModel.allRecipesUpdated = { [weak self] in
                print("All Recipes callback received")
//                defer {
//                    dispatchGroup.leave()
//                }
                self?.reloadTableView()
            }
            self.allRecipesViewModel.fetchAllRecipes()
            
            // MARK: - Completion
            
            dispatchGroup.notify(queue: .main) { [weak self] in
                print("All API calls completed. Hiding loader.")
                self?.hideLoader()
            }
            
        }
    }
    
    func reloadTableView() {
        print("Reloading TableView...")

        guard let tableView = self.allRecipiesTableView else {
            print("tableView is nil!")
            return
        }
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

