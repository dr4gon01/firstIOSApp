//
//  ViewController.swift
//  BullsEye
//
//  Created by Nirmesh Gollamandala on 11/14/17.
//  Copyright © 2017 Nirmesh Gollamandala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue  = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundsLabel : UILabel!
    var targetValue: Int = 0
    var score = 0
    var rounds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        reset()
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        rounds += 1
        updateLabels()
    }

    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundsLabel.text = String(rounds)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMoved(_ slider:UISlider){
        print("the value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
            }
    
    @IBAction func reset(){
        score = 0
        rounds = 0
        startNewRound()
    }
    
    @IBAction func showMessage(){
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        score += points

        let title : String
        if difference == 0 {
            title = "perfect!"
            points += 100
        }
        else if difference < 10 {
            title = "Good!"
            points += 50
        }
        else {title = "Try Again"}
        
        let message = "you scored \(points) points"
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: {
            //closures
            action in
            self.startNewRound()
        })
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

