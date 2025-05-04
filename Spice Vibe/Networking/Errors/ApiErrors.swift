//  ApiErrors.swift
//  Spice Vibe
//  Created by caglobal on 04/03/25.

import Foundation
import UIKit

enum ApiError: Error {
    case invalidURL
    case requestFailed(error: Error)
    case invalidResponse
    case decodingError(error: Error)
    case serverError(statusCode: Int)
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .noInternet:
            return "No internet connection. Please check your network."
        }
    }
    
    static func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let rootVC = keyWindow.rootViewController {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                rootVC.present(alert, animated: true)
            }
        }
    }
    
    static func handleApiErrors(error:ApiError){
        
        var errorMessage = "Something went wrong"
        
        switch error {
        case .noInternet:
            errorMessage = "No internet connection. Please check your network."
        case .decodingError(let decodingError):
            errorMessage = "Failed to decode data: \(decodingError.localizedDescription)"
        case .requestFailed(let requestError):
            errorMessage = "API request failed: \(requestError.localizedDescription)"
        case .invalidURL:
            errorMessage = "The API URL is invalid."
        case .invalidResponse:
            errorMessage = "The server sent an invalid response."
        case .serverError(let statusCode):
            errorMessage = "Server error occurred with status code: \(statusCode)."
        }
        
        self.showAlert(title: "Error", message: errorMessage)
    }
}

