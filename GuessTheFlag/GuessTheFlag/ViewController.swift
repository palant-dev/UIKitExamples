//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Antonio Palomba on 30/08/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var maxNumberOfRounds = 10
    var round: (counter: Int, roundType: roundCase) = (1, .normalRound)

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france","germany", "ireland", "italy", "monaco" , "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased() + " - Round \(round.counter)/\(maxNumberOfRounds)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String = ""
        if round.counter < maxNumberOfRounds {
            round.roundType = .normalRound
        } else {
            round.roundType = .lastRound
        }

        alertButtonBehaviour(roundType: round.roundType, sender: sender)

        round.counter += 1

        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: round.roundType == .normalRound ? "Continue" : "Restart", style: .default, handler: askQuestion))

        present(ac, animated: true)

        if round.roundType == .lastRound {
            round = (1, .normalRound)
            score = 0
        }
    }

    func alertButtonBehaviour(roundType: roundCase, sender: UIButton) {
        switch roundType {
            case .normalRound:
            if sender.tag == correctAnswer {
                title = "Correct"
                score += 1
            } else {
                title = "Wrong, this is \(countries[sender.tag].uppercased())"
                score -= 1
            }
        case .lastRound:
            if sender.tag == correctAnswer {
                title = "Correct, this was the last round"
                score += 1
            } else {
                title = "Wrong, this is \(countries[sender.tag].uppercased()), this was the last round"
                score -= 1
            }
        }
    }

    
}



enum roundCase: Int {
    case normalRound
    case lastRound
}


