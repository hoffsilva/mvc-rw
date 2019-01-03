//
//  ViewController.swift
//  mvc-rw
//
//  Created by Hoff Henry Pereira da Silva on 02/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class QuestionController: UIViewController {
    
    //MARK - Instance properties
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    //Index of displayed question
    public var questionIndex  = 0
    //number of correct aswers
    public var correctCount   = 0
    //number of incorret answers
    public var incorrectCount = 0
    //computed property -
    public var questionView: QuestionView! {
        guard isViewLoaded else {
            return nil
        }
        return (view as! QuestionView)
    }

    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text   = question.hint ?? "No hint"
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden   = true
        
        questionIndexItem.title = String(questionIndex + 1) + "/" + String(questionGroup.questions.count)
    }
    
    //MARK - Actions
    @IBAction func toggleAnswerLabel(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        correctCount += 1
        updateCountLabels()
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        incorrectCount += 1
        updateCountLabels()
        showNextQuestion()
    }
    
    private func updateCountLabels() {
        questionView.correctCountLabel.text   = String(correctCount)
        questionView.incorrectCountLabel.text = String(incorrectCount)
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            let alert = UIAlertController(title: "You answered all questions", message: "Do you want to restart the game?", preferredStyle: UIAlertController.Style.actionSheet)
            let reset = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (action) in
                self.resetControllers()
            }
            let dismiss = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(reset)
            alert.addAction(dismiss)
            present(alert, animated: true, completion: nil)
            return
        }
        showQuestion()
    }
    
    private func resetControllers() {
        correctCount   = 0
        incorrectCount = 0
        questionIndex  = 0
        showQuestion()
        updateCountLabels()
    }


}

