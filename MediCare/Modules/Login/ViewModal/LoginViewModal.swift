//
//  LoginViewModal.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/27/22.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class LoginViewModel{
    

func requestForLogin(Username: String, Password: String, success: @escaping (LoginResponseModel) -> Void, fail: @escaping (String) -> Void) {
    
    
    let params: [String: String] = [
        "Username" : Username,
        "Password" : Password,
    ]
    
    let url = BASE_URL + LOGIN_EP
    
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseObject(completionHandler: { (response: DataResponse<LoginResponseModel>) in
        print(url)
        switch response.result {
        case .success(let value):
            success(value)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    })
}
}
