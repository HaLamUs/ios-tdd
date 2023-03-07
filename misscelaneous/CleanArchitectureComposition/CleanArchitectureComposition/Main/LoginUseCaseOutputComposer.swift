//
//  LoginUseCaseOutputComposer.swift
//  CleanArchitectureComposition
//
//  Created by lamha on 07/03/2023.
//

import Foundation

// 1. Composing using class
final class LoginUseCaseOutputComposer: LoginUseCaseOutput {
    
    var outputs: [LoginUseCaseOutput]
    init(_ outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    
    func loginSucceeded() {
        outputs.forEach { $0.loginSucceeded() }
    }
    
    func loginFailed() {
        outputs.forEach { $0.loginFailed() }
    }
}

// 2. Composing using function
/*
 Input: array of func
 Output: func
 return all the function in the array with the given value
 
 */

func compose<T>(_ outputs: [(T) -> Void]) -> (T) -> Void {
    return {
        value in
        outputs.forEach { $0(value) }
    }
}


// Below is the demo
func compose3(_ outputs: [() -> Void]) -> () -> Void {
    return {
        outputs.forEach { $0() }
    }
}

func compose4(_ outputs: [(String) -> Void]) -> (String) -> Void {
    return {
        value in
        outputs.forEach { $0(value) }
        // $0 belongs to outputs
    }
}

func compose2() -> (String) -> Void {
    return {
        value in
        print("\n \n \n This is the value \(value) \n \n \n")
    }
}
