//
//  RandomQuestionStrategy.swift
//  mvc-rw
//
//  Created by Hoff Henry Pereira da Silva on 04/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import GameplayKit

public class RandomQuestionStrategy: QuestionStrategy {
    
    //MARK - Properties
    
    public  var correctCount  : Int = 0
    
    public  var incorrectCount: Int = 0
    
    private let questionGroup : QuestionGroup
    
    private var questionIndex = 0
    
    private let questions     : [Question]
    
    //MARK - Object lifecycle
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        let randomSource = GKRandomSource.sharedRandom()
        self.questions   = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
    }
    
    //MARK - QuestionStrategy
    public  var title         : String {
        return questionGroup.title
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    public func markQuestionCorrect(question: Question) {
        correctCount += 1
    }
    
    public func markQuestionIncorrect(question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return String(questionIndex + 1) + "/" + String(questions.count)
    }
    
    
}

