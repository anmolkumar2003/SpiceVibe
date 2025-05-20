//  DetailedRecipeViewController.swift
//  Spice Vibe
//  Created by mac on 23-02-2025.

import UIKit
import SDWebImage
import Alamofire

class DetailedRecipeViewController: UIViewController {
    
    @IBOutlet weak var servingsLbl: UILabel!
    @IBOutlet weak var tagLbl2: UILabel!
    @IBOutlet weak var tagLbl1: UILabel!
    @IBOutlet weak var reviewCountLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var recipeImageDescription: UIImageView!
    @IBOutlet weak var caloriesPerServingLbl: UILabel!
    @IBOutlet weak var difficultyLbl: UILabel!
    @IBOutlet weak var cusineLbl: UILabel!
    @IBOutlet weak var cookTimeMinutesLbl: UILabel!
    @IBOutlet weak var preprationTimeMinutesLbl: UILabel!
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
    var heartButtonStatus = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDataToUi()
    }
    
    
    func assignDataToUi(){
        if let imageUrl = URL(string: recipe?.image ?? "UIImage") {
            recipeImage.sd_setImage(with: imageUrl)
        }
        if let ingredients = recipe?.ingredients{
            let formattedIngridients = ingredients.joined(separator: "\n")
            ingridientsLbl.text = "\(formattedIngridients)"
        }
 
        if let instructions = recipe?.instructions {
            let formattedInstructions = instructions.joined(separator: "\n")
            instructionsTextView.text = formattedInstructions
        }
        
        if let mealType = recipe?.mealType{
            let mealFormatter = mealType.joined(separator: "\n")
            lblMealType.text = "\(mealFormatter)"
        }
         
        if let recipeName = recipe?.name{
            recipeNameLbl.text = "\(recipeName)"
        }
        
        if let preprationTime = recipe?.prepTimeMinutes{
            preprationTimeMinutesLbl.text = ("\(preprationTime)")
        }
        
        if let cookTime = recipe?.cookTimeMinutes{
            cookTimeMinutesLbl.text = ("\(cookTime)")
        }
        
        if let cusine = recipe?.cuisine{
            cusineLbl.text = ("\(cusine)")
        }
        
        if let servings = recipe?.servings{
            servingsLbl.text = ("\(servings)")
        }
        
        if let difficulty = recipe?.difficulty{
            difficultyLbl.text = ("\(difficulty)")
        }
        
        if let caloriesPerServing = recipe?.caloriesPerServing{
            caloriesPerServingLbl.text = "\(caloriesPerServing)"
        }
        
        if let rating = recipe?.rating{
            ratingLbl.text = ("⭐️⭐️⭐️⭐️\(rating)")
        }
        
        if let reviewCount = recipe?.reviewCount{
            reviewCountLbl.text = ("\(reviewCount)")
        }
        
        if let recipeImg = URL(string: recipe?.image ?? "UIImage"){
            recipeImageDescription.sd_setImage(with: recipeImg)
        }
        
        if let tagLbl = recipe?.tags{
            tagLbl1.text = tagLbl.first
        }
        
        if let tag2 = recipe?.tags{
            tagLbl2.text = tag2.last
        }
    }
    
    @IBAction func heartButton(_ sender: Any) {
        heartButtonStatus.toggle()
        if heartButtonStatus == true{
            heartButton.tintColor = .red
            heartButton.setImage(UIImage(named: "heart-Red"), for: .normal)
        } else{
            heartButton.setImage(UIImage(named: ""), for: .normal)
            heartButton.tintColor = .black
        }
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
