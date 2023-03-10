//
//  Question.swift
//  QuizEngineX
//
//  Created by lamha on 11/11/2022.
//

import Foundation
//dont care type cause we want support other type of question still have single or multiple option (answer)
// with this implement we have both answer support single, multi and question with dont care type
public enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    // we dont need this any more
//    public func hash(into hasher: inout Hasher) {
//        switch self {
//        case .singleAnswer(let t):
//            return hasher.combine(t)
//        case .multipleAnswer(let t):
//            return hasher.combine(t)
//        }
//    }
    
//    public var hashValue: Int {
//        switch self {
//        case .singleAnswer(let t):
//            return "singleAnswer".hashValue ^ t.hashValue
//        case .multipleAnswer(let t):
//            return  "multipleAnswer".hashValue ^ t.hashValue
//        }
//    }
    
    //swift already supp we dont need anymore
//    public static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
//        switch (lhs, rhs) {
//        case (.singleAnswer(let a), .singleAnswer(let b)):
//            return a == b
//        case (.multipleAnswer(let a), .multipleAnswer(let b)):
//            return a == b
//        default:
//            return false
//        }
//    }
}

// we dont need these anymore we can just use enum + dont care type
//protocol QuestionType: Hashable {
//    var type: Question { get }
//}
//
//// Future: we may have more imageQues, vidQues
//struct ConcreteQuestion: QuestionType {
//    let question: String
////    let isMultipleQuestion: Bool
//    let type: Question
//}
