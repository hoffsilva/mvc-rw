//
//  SelectQuestionGroupController.swift
//  mvc-rw
//
//  Created by Cast Group on 03/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class SelectQuestionGroupController: UIViewController {
    
    //MARK - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    //MARK - Properties
    public let questionGroups = QuestionGroup.allGroups()
    public var selectedQuestionGroup: QuestionGroup!
    
    //MARK - Navigation
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? QuestionController else {
            return
        }
        controller.questionGroup = selectedQuestionGroup
        controller.questionControllerDelegate = self
    }
    
}

//MARK - Table view datasource
extension SelectQuestionGroupController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionGroupCell", for: indexPath) as! QuestionGroupView
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        return cell
    }
}

//MARK - Table view delegate
extension SelectQuestionGroupController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK - QuestionControllerDelegate

extension SelectQuestionGroupController: QuestionControllerDelegate {
    func questionViewController(_ controller: QuestionController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ controller: QuestionController, didCancel questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    
}
