//
//  UserDefaultsManager.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/27/22.
//

import Foundation
import UIKit

class UserDefaultManager {
    
    static let shared       = UserDefaultManager()
    private let userDefault = UserDefaults.standard
    
    
    
    
    
    var accessToken: String {
        get{
            let token : String = getModel(key: "ACCESS_TOKEN") ?? ""
            return token
        }
        set{
            saveModel(model: newValue, key: "ACCESS_TOKEN")
        }
    }
    
    
    
    
    //MARK:- Saving and retrieving data model
    private func saveModel<T: Codable> (model : T, key: String) {
        let encoder    = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            userDefault.set(encoded, forKey: key)
        }
    }
    
    private func getModel<T: Codable> (key: String) -> T? {
        if let model     = userDefault.object(forKey: key) as? Data {
            let decoder  = JSONDecoder()
            if let model = try? decoder.decode(T.self, from: model) {
                return model
            }
        }
        return nil
    }
    
    
}

//extension UserDefaults{
//    func setIsLoggedIn(value: Bool) {
//        set(false, forKey: "isLoggedIn")
//    }
//
//    func isLoggedIn() -> Bool {
//        return bool(forKey: "isLoggedIn")
//    }
//}
