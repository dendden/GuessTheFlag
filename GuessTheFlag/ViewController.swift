//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Денис Трясунов on 11/11/16.
//  Copyright © 2016 Денис Трясунов. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    var countries = [String]()
    var guessedCountries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func askQuestion(action: UIAlertAction! = nil) {
        repeat {
            countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
            correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        } while guessedCountries.contains(countries[correctAnswer])
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            guessedCountries.append(countries[correctAnswer])
        } else {
            title = "Wrong..."
            score -= 1
        }
        scoreLbl.text = "\(score)"
        
        if guessedCountries.count == countries.count {
            let winAlert = UIAlertController(title: "Congrats!", message: "You know all the flags!", preferredStyle: .alert)
            winAlert.addAction(UIAlertAction(title: "Play again", style: .destructive, handler: playAgain))
            present(winAlert, animated: true)
        } else {
            let alert = UIAlertController(title: title, message: "Try again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            alert.addAction(UIAlertAction(title: "End", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    func playAgain(action: UIAlertAction) {
        guessedCountries.removeAll()
        score = 0
        scoreLbl.text = "\(score)"
        askQuestion()
    }

}

