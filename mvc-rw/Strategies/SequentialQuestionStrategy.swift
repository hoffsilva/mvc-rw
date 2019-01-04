//
//  SequentialQuestionStrategy.swift
//  mvc-rw
//
//  Created by Cast Group on 03/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

public class SequentialQuestionStrategy: QuestionStrategy {
    
    // MARK: - Properties
    
    private let questionGroup: QuestionGroup
    
    private var questionIndex = 0
    
    public var title: String {
        return questionGroup.title
    }
    
    public var correctCount: Int = 0
    
    public var incorrectCount: Int = 0
    
    // MARK: Object Lifecycle
    
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    
    public func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    
    public func markQuestionCorrect(question: Question) {
        correctCount += 1
    }
    
    public func markQuestionIncorrect(question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return String(questionIndex + 1) + "/" + String(questionGroup.questions.count)
    }
    
    
    
    
    
}
