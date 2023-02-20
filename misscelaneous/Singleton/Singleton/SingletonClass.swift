//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation

class ApiClient {
    
    private static let instance = ApiClient()
    
    static func getInstance() -> ApiClient {
        instance
    }
    
    private init() {}
}


let client = ApiClient.getInstance()
