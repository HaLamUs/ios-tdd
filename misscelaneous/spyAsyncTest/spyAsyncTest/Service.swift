//
//  Service.swift
//  spyAsyncTest
//
//  Created by lamha on 15/03/2023.
//

import Foundation

public class Service {
    
    func load(completion: @escaping (String) -> ()) {
        DispatchQueue.global(qos: .background).async {
            sleep(5)
            completion("Done")
        }
    }
}
