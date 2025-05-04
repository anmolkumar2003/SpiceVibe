//  NetworkManager.swift
//  Spice Vibe
//  Created by caglobal on 04/03/25.

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private let reachabilityManager = NetworkReachabilityManager()
    
    var isInternetAvailable: Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    func startMonitoring() {
        reachabilityManager?.startListening { status in
            switch status {
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                print("Internet Working API call...")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "internetIsWorking"), object: nil)
            case .notReachable:
                print("No internet connection.")
            case .unknown:
                print("Network status unknown.")
            }
        }
    }
}
