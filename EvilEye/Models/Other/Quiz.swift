//
//  Quiz.swift
//  EvilEye
//
//  Created by Alexander Meurer on 9/3/23.
//

import SwiftUI

struct Quiz: Identifiable {
    var id = UUID().uuidString
    var question: String
    var answer: Double
    var type: QuizType
    
    enum QuizType {
        case manual //- TextField Input
        case toChooseFrom(a: Double,b: Double, c: Double, d: Double)
    }
    
}

extension Quiz {
    static var allQuestions: [Quiz] = [
        Quiz(question: "What is 3 x 30 ?", answer: 90, type: .manual),
        Quiz(question: "What is 2 + 10 x 3 ?", answer: 32, type: .toChooseFrom(a: 36, b: 15, c: 32, d: 33)),
        Quiz(question: "What is 5 + 5?", answer: 10, type: .manual),
        Quiz(question: "What is 12 / 3 ?", answer: 4, type: .toChooseFrom(a: 3, b: 5, c: 4, d: 2)),
        Quiz(question: "What is 7 x 9 ?", answer: 63, type: .manual),
        Quiz(question: "What is 20 - 4 ?", answer: 16, type: .toChooseFrom(a: 14, b: 16, c: 18, d: 19)),
        Quiz(question: "What is 100 / 4 ?", answer: 25, type: .manual),
        Quiz(question: "What is 3 x 3 x 3 ?", answer: 27, type: .toChooseFrom(a: 26, b: 27, c: 28, d: 29)),
        Quiz(question: "What is 10 x 10 ?", answer: 100, type: .manual),
        Quiz(question: "What is 9 + 9 ?", answer: 18, type: .toChooseFrom(a: 19, b: 20, c: 18, d: 17)),
        Quiz(question: "What is 7 x 7 ?", answer: 49, type: .manual),
        Quiz(question: "What is 50 / 2 ?", answer: 25, type: .toChooseFrom(a: 24, b: 26, c: 25, d: 27)),
        Quiz(question: "What is 15 + 20 ?", answer: 35, type: .manual),
        Quiz(question: "What is 21 / 3 ?", answer: 7, type: .toChooseFrom(a: 6, b: 7, c: 8, d: 9)),
        Quiz(question: "What is 6 x 5 ?", answer: 30, type: .manual),
        Quiz(question: "What is 40 - 25 ?", answer: 15, type: .toChooseFrom(a: 14, b: 16, c: 17, d: 15)),
        Quiz(question: "What is 20 x 3 ?", answer: 60, type: .manual),
        Quiz(question: "What is 18 / 2 ?", answer: 9, type: .toChooseFrom(a: 9, b: 8, c: 10, d: 7)),
        Quiz(question: "What is 2 x 2 x 2 ?", answer: 8, type: .manual),
        Quiz(question: "What is 30 - 5 ?", answer: 25, type: .toChooseFrom(a: 24, b: 25, c: 26, d: 23)),
        Quiz(question: "What is 10 + 10 x 2 ?", answer: 30, type: .manual),
        Quiz(question: "What is 16 / 4 ?", answer: 4, type: .toChooseFrom(a: 3, b: 5, c: 4, d: 2)),
        Quiz(question: "What is 8 + 8 ?", answer: 16, type: .manual),
        Quiz(question: "What is 5 x 12 ?", answer: 60, type: .toChooseFrom(a: 58, b: 60, c: 62, d: 64))
    ]
}

