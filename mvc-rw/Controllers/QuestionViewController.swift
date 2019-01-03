//
//  ViewController.swift
//  mvc-rw
//
//  Created by Hoff Henry Pereira da Silva on 02/01/19.
//  Copyright © 2019 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //MARK - Instance properties
    public var questionGroup  = QuestionGroup.basicPhrases()
    public var questionIndex  = 0
    
    public var correctCount   = 0
    public var incorrectCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else {
            return nil
        }
        return view as? QuestionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

