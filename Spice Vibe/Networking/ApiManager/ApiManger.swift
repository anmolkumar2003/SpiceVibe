//  ApiManger.swift
//  Spice Vibe
//  Created by mac on 01-03-2025.

import Foundation
import Alamofire

class ApiManager: NSObject{
    
    let networkManager = NetworkReachabilityManager()
    
    // Fetch Random Recipes
    func fetchRecipesResponse(completion: @escaping ([Recipe]?,ApiError?) -> Void) {
        guard let isReachable = networkManager?.isReachable, isReachable else {
            completion(nil, ApiError.noInternet)
            return
        }
        AF.request(ApiLinks.recipesApiLink, method: .get, encoding: URLEncoding.queryString)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(Welcome.self, from: data)
                        completion(jsonData.recipes, nil)
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        completion(nil, ApiError.decodingError(error: error))
                    }
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                    completion(nil, ApiError.requestFailed(error: error))
                }
            }
    }
    
    // Fetch Meal Categories
    func fetchMealCategories(completion: @escaping ([Category]?,ApiError?) -> Void) {
        guard let isReachable = networkManager?.isReachable, isReachable else {
            completion(nil, ApiError.noInternet)
            return
        }
        AF.request(ApiLinks.recipeCategoriesApiLink, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil, interceptor: nil)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(RecipeCategories.self, from: data!)
                        completion(jsonData.categories, nil)
                    } catch {
                        print("Failed to decode: \(error.localizedDescription)")
                        completion(nil, ApiError.decodingError(error: error))  // Return nil in case of error
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    completion(nil, ApiError.requestFailed(error: error))  // Return nil in case of failure
                }
            }
    }
}
