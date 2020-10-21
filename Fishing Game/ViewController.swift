//
//  ViewController.swift
//  Fishing Game
//
//  Created by Steuber, Brian William on 10/12/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var secondsLabel: UILabel!
    
    
    
    var gameOver = false
    var timer: Timer? = nil
        // try working wiht this
    var seconds: Int = 60 {
        didSet {
            secondsLabel.text = "\(seconds)s"
        }
    }
    
    
    
    
    
    
    
    
    
    func gameOverFunc() {
        let alertController = UIAlertController(title: "Game Over", message: "You scored: ", preferredStyle: .alert)
        // Action for when the Okay button is pressed
        alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action) -> Void in
            self.seconds = 60
            self.gameOver = false
            /*
            let alertController = UIAlertController(title: "Drop a Line", message: "Tap on a cell to drop your line, then wait and see if you caught a fish!", preferredStyle: .alert)
             */
        }))
    }
    
    // timer stops but no alert comes up when game is done
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
             if self.gameOver == false {
                self.seconds -= 1
                    if (self.seconds == 0) {
                        print(self.seconds)
                        self.gameOver = true
                        //maybe?
                        //self.newGamePressed(<#T##sender: UIButton##UIButton#>)
                        // NOT WORKING
                        
                    }
            }
           

            
            // fully qualify external reference names
            // recall closures "capture" external refernces
            // closures execute LATER
            // potentially, the ViewController could be deallocated and the closure tries to refer to its seconds property... bad
            // closures keep their external references in scope/memory
        })
    }
    
    func stopTimer() {
           timer?.invalidate() // optional chaining
           timer = nil
       }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        self.stopTimer()
        
        let alertController = UIAlertController(title: "Game Over", message: "You scored: ", preferredStyle: .alert)
        // Action for when the Okay button is pressed
        alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action) -> Void in
            self.seconds = 60
            self.startTimer()
            
        }))
        // Alert the consle when the alert shows on the screen to the user
        present(alertController, animated: true, completion: { () -> Void in
            print("Alert Just presented")
        })
        print("Bet")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("Button Pressed")
        // how do we know what button was pressed?
        // 2 ways
        // use an outlet connection
        print("tag: \(sender.tag)")
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func intro() {
        let alertController = UIAlertController(title: "Welcome to Carpet Fishing!", message: "Tap a cell to drop your fishing line in carpet sea. After a second, you'll see if you caught a fish. In 60 seconds, try to get the highest score you can. Here are the available fish in Carpet Sea.", preferredStyle: .alert)
            // Action for when the Okay button is pressed
            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
                self.prepUser()
            }))
            // Alert the consle when the alert shows on the screen to the user
            present(alertController, animated: true, completion: { () -> Void in
                print("Alert Just presented")
            })
        }
    
    func prepUser() {
       let alertController = UIAlertController(title: "Drop a Line", message: "Tap on a cell to drop your line, then wait and see if you caught a fish!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
            self.startTimer()
        }))
        // Alert the consle when the alert shows on the screen to the user
        present(alertController, animated: true, completion: { () -> Void in
            print("Alert Just presented")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.intro()
        
    }
}

