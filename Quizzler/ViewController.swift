//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var questionIndex : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        var pickedAnswer : Bool = false
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if (sender.tag == 2) {
            pickedAnswer = false
        }
        
        checkAnswer(answer: pickedAnswer)
        
        questionIndex += 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionIndex + 1) / \(allQuestions.list.count)"
        
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionIndex + 1)
        
    }
    

    func nextQuestion() {
        
        if questionIndex <= allQuestions.list.count - 1 {
            
            questionLabel.text = allQuestions.list[questionIndex].questionText
            
            updateUI()
            
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { UIAlertAction in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer(answer : Bool) {
        
        let correctAnswer = allQuestions.list[questionIndex].answer
        
        if correctAnswer == answer {
            
            ProgressHUD.showSuccess("Correct")
            
            score += 1
            
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        
        questionIndex = 0
        score = 0
        updateUI()
        nextQuestion()
        
    }
    

    
}
