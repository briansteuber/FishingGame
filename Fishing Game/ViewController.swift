//
//  ViewController.swift
//  Fishing Game
//  This class creates an instance of type CarpetSea and communicates
//  this with Main.storyboard to create a CarpetSea game.
//  Controller in MVC
//  CPSC 315-02, Fall 2020
//  Programming Assignment #5
//  No sources to cite
//
//  Created by Steuber, Brian William on 10/12/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var secondsLabel: UILabel!
    
    // implemention consultant intern
    // zagignite
    
    // vertical stack views of
        // Score and 0
        // Timer and 60 seconds
        // Total 60s and stepper
    
    // Then put those into a horizontal stack view
        
    // make sure everything is in a vertical stack view at the end
    
    
    var wasCast = false
    var sea = CarpetSea(n: 2)
    var cellPosition: (Int, Int) = (0,0)
    var score = 0
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
            self.prepUser()
            /*
            let alertController = UIAlertController(title: "Drop a Line", message: "Tap on a cell to drop your line, then wait and see if you caught a fish!", preferredStyle: .alert)
             */
        }))
        present(alertController, animated: true, completion: { () -> Void in
            print("Alert Just presented")
        })
    }
    
    // timer stops but no alert comes up when game is done
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.seconds > 0 {
                self.seconds -= 1
            }
                /*
                 if (self.seconds == 0) {
                     print(self.seconds)
                     // self.prepUser()
                 }
                 
                 */
            if self.seconds == 0 {
                self.gameOverFunc()
                self.stopTimer()
                
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
        let alertController = UIAlertController(title: "Welcome to Carpet Fishing!", message: "Tap a cell to drop your fishing line in carpet sea. After a second, you'll see if you caught a fish. In 60 seconds, try to get the highest score you can. Here are the available fish in Carpet Sea: \(sea.availableFish)", preferredStyle: .alert)
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

