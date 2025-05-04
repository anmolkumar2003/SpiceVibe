//  DetailedRecipeViewController.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import UIKit
import SDWebImage
import Alamofire

class DetailedRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLbl: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var lblMealType: UILabel!
    @IBOutlet weak var ingridientsLbl: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    var recipe: Recipe?
    var recipeImg = UIImage()
    var ingridientText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = URL(string: recipe?.image ?? "UIImage") {
            recipeImage.sd_setImage(with: imageUrl)
        }
        if let ingredients = recipe?.ingredients{
            ingridientsLbl.text = "\(ingredients)"
        }
        if let instructions = recipe?.instructions{
            instructionsTextView.text = "\(instructions)"
        }
        if let mealType = recipe?.mealType{
            lblMealType.text = "\(mealType)"
        }
         
        if let recipeName = recipe?.name{
            recipeNameLbl.text = "\(recipeName)"
        }
    }
    @IBAction func heartButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let img = recipeImg
        let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender as! UIView
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}
