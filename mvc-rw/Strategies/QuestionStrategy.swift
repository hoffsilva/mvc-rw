//
//  QuestionStrategy.swift
//  mvc-rw
//
//  Created by Cast Group on 03/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: class {
    
    var title: String { get }
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    func currentQuestion() -> Question
    
    func markQuestionCorrect(question: Question)
    func markQuestionIncorrect(question: Question)
    
    func questionIndexTitle() -> String
    
}
