//
//  Service.swift
//  spyAsyncTest
//
//  Created by lamha on 15/03/2023.
//

import Foundation

public protocol Service {
    func load(completion: @escaping (String) -> ())
}

