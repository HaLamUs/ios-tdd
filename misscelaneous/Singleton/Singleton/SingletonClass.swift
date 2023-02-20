//
//  SingletonClass.swift
//  Singleton
//
//  Created by lamha on 20/02/2023.
//

import Foundation

class ApiClient {
    static let instance = ApiClient()
    
    private init() {}
}


let client = ApiClient.instance
