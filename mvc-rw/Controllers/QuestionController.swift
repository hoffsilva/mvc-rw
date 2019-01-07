//
//  ViewController.swift
//  mvc-rw
//
//  Created by Hoff Henry Pereira da Silva on 02/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

//MARK - QuestionControllerDelegate

protocol QuestionControllerDelegate: class {
    func questionViewController(_ controller: QuestionController, didCancel questionGroup: QuestionStrategy, at questionIndex: Int)
    func questionViewController(_ controller: QuestionController, didCancel questionGroup: QuestionStrategy)
}

class QuestionController: UIViewController {
    
    //MARK - Instance properties
    public weak var questionControllerDelegate: QuestionControllerDelegate?
    public var questionStrategy: QuestionStrategy! {
        didSet {
            navigationItem.title = questionStrategy.title
        }
    }
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
        setupCancelButton()
        showQuestion()
        
    }
    
    private func showQuestion() {
        let question = questionStrategy.currentQuestion()
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text   = question.hint ?? "No hint"
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden   = true
        
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = #imageLiteral(resourceName: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: nil, style: .plain, target: self, action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        questionControllerDelegate?.questionViewController(self, didCancel: questionStrategy, at: questionIndex)
    }
    
    //MARK - Actions
    @IBAction func toggleAnswerLabel(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question: question)
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question: question)
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }
    
    private func updateCountLabels() {
        questionView.correctCountLabel.text   = String(correctCount)
        questionView.incorrectCountLabel.text = String(incorrectCount)
    }
    
    private func showNextQuestion() {
        guard questionStrategy.advanceToNextQuestion() else {
            questionControllerDelegate?.questionViewController(self, didCancel: questionStrategy)
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

