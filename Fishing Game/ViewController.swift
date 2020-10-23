//
//  ViewController.swift
//  Fishing Game
//  This class creates an instance of type CarpetSea and communicates
//  this with Main.storyboard to create a CarpetSea game.
//  Controller in MVC
//  CPSC 315-02, Fall 2020
//  Programming Assignment #5
//  Class Zoom Videos & Dr. Sprint's help with Auto Layout
//  Extra Credit Completed 
//
//  Created by Steuber, Brian William on 10/12/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Array of UIButtons
    @IBOutlet var buttons: [UIButton]!
    // Score Label
    @IBOutlet var scoreLabel: UILabel!
    // Seconds Label
    @IBOutlet var secondsLabel: UILabel!
    // Total Seconds Label
    @IBOutlet var totalSecondsLabel: UILabel!
    // UIStepper
    @IBOutlet var UIStepperLabel: UIStepper!
    
    // Index of the Button that was pressed 
    var indexButtons = 0
    // Error check to fix a bug at the beginning of the game
    var errorCheck = 0
    // Carpet Sea object
    var sea = CarpetSea(n: 2)
    // Number of cells (2*2)
    var count = 4
    // Initial Cell Position
    var cellPosition: (Int, Int) = (0,0)
    // Game Score
    var score = 0
    // Varibale for if the line was cast
    var wasCast = false
    // Timer object
    var timer: Timer? = nil
    // Timer object 2
    var timer2: Timer? = nil
    // Total Seconds
    var totalSeconds = 60
    // Variable for seconds
    var seconds: Int = 60 {
        didSet {
            secondsLabel.text = "\(seconds)s"
        }
    }
    // Variable for seconds2
    var seconds2: Int = 1
    
    // Function that overrides viewDidLoad/Interacts with UIStepper
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIStepperLabel.minimumValue = 30
        UIStepperLabel.value = 60
        UIStepperLabel.maximumValue = 120
        UIStepperLabel.stepValue = 5
        UIStepperLabel.wraps = false
        UIStepperLabel.autorepeat = true
    }
    
    // Function that overrides viewDidAppear
    // Has the intro function appear when the app begins
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Take them to intro function
        self.intro()
    }
    
    // Function to Greet the user and prep them for the game
    // When Okay is pressed, the user is taken to the prepUser function
    func intro() {
        let greeting = UIAlertController(title: "Welcome to Carpet Fishing!", message: "Tap a cell to drop your fishing line in carpet sea. After a second, you'll see if you caught a fish. In 60 seconds, try to get the highest score you can. Here are the available fish in Carpet Sea \(sea.availableFish)", preferredStyle: .alert)
            // Action for when the Okay button is pressed
            greeting.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
                // Prep the user for the game
                self.prepUser()
            }))
            present(greeting, animated: true, completion: { () -> Void in })
        }
    
    // Function to inform the user to tap on a cell to cast their line
    // When Okay is pressed, the user is taken to the main screen and the timer starts
    func prepUser() {
       let dropLine = UIAlertController(title: "Drop a Line", message: "Tap on a cell to drop your line, then wait and see if you caught a fish!", preferredStyle: .alert)
        // Action for when the Okay button is pressed
        dropLine.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
            self.startTimer()
        }))
        present(dropLine, animated: true, completion: { () -> Void in })
    }
    
    // Function that starts the countdown
    // If time runs out then the clock stops and the gameOver function is called
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            // While there is time on the clock
            if self.seconds > 0 {
                // Decrement the seconds
                self.seconds -= 1
                // Time has run out
                if self.seconds == 0 {
                    // Stop the timer
                    self.stopTimer()
                    // Call gameOver
                    self.gameOverFunc()
                }
            }
        })
    }
    
    // Resets the Cells
    func resetCells() {
        // Reset the button titles to normal
        for buttons in 0..<self.count {
            self.buttons[buttons].setTitle("", for: UIControl.State.normal)
        }
        // Clear out the lines and sets fish to nil
        for row in 0..<self.sea.n {
            for col in 0..<self.sea.n {
                self.sea.grid[row][col].containsLine = false
                self.sea.grid[row][col].fish = nil
            }
        }
        // Sets wasCast to true
        self.wasCast = false
    }
    
    // Function that handles when a button is pressed
    // Places a random fish and sets the cell Position of where the user tapped
    // Changes to 🎣 if the user has caught a fish
    // As long as there is time on the clock, check to see if the user has cast
    // When the user touches a cell, this function alerts them if they caught a fish or not
    // Resets the status of the cells
    @IBAction func buttonPressed(_ sender: UIButton) {
        wasCast = true
        // User did click on a button
        errorCheck += 1
        // If a line was cast
        if(wasCast) {
            // Place a random fish in the sea object
            sea.randomlyPlaceFish()
            // Get the index of the button
            if let i = buttons.firstIndex(of: sender) {
                // Set global variable to i
                indexButtons = i
                // Set the title to ⌇
                buttons[i].setTitle("⌇", for: UIControl.State.normal)
                // Sets the cellPosition to the coordinates of the 1st button
                if (buttons[i] == buttons[0]) {
                    cellPosition = (0,0)
                }
                // Sets the cellPosition to the coordinates of the 2nd button
                if (buttons[i] == buttons[1]) {
                    cellPosition = (0,1)
                }
                // Sets the cellPosition to the coordinates of the 3rd button
                if (buttons[i] == buttons[2]) {
                    cellPosition = (1,0)
                }
                // Sets the cellPosition to the coordinates of the 4th button
                if (buttons[i] == buttons[3]) {
                    cellPosition = (1,1)
                }
                // Drop the line in the cellPosition
                sea.dropFishingLine(cellPosition: cellPosition)
            }
            // Timer that is 1 second
            timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer2) in
                // Time on the clock
                if (self.seconds2) > 0 {
                    // If there is a fish in the cell the user tapped
                    if (self.sea.checkFishCaught(cellPosition: self.cellPosition) != nil) {
                        // Set the title to 🎣 - caught
                        self.buttons[self.indexButtons].setTitle("🎣", for: UIControl.State.normal)
                    }
                    // Possible Catch
                    let maybeACatch = self.sea.checkFishCaught(cellPosition: self.cellPosition)
                    // if there was no catch
                    if (self.wasCast == false) {
                        // If the user selected a cell with a fish in it
                        if (maybeACatch != nil) {
                            // Make a fish variable
                            let fishScore: Int = self.sea.availableFish["\(maybeACatch!)"]!
                            // Display an alert
                            let theCatch = UIAlertController(title: "Reel in your line", message: "You caught a \(maybeACatch!) worth \(fishScore) points", preferredStyle: .alert)
                            // Action for when the Okay button is pressed
                            theCatch.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
                                // Update the Game Score
                                self.updateScore(fish: maybeACatch!)
                                // Reset Cells
                                self.resetCells()
                                // If time is up, then go to gameOver
                                if (self.seconds == 0) {
                                    self.gameOverFunc()
                                }
                            }))
                            self.present(theCatch, animated: true, completion: {() -> Void in})
                        }
                        // If a button is clicked for the errorCheck case
                        if (maybeACatch == nil) {
                            // Display an Alert
                            let noCatch = UIAlertController(title: "Reel in your line", message: "Looks like you didn't catch a fish! Press okay to drop a new line.", preferredStyle: .alert)
                            // Action for when the Okay button is pressed
                            noCatch.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) -> Void in
                                // Reset Cells
                                self.resetCells()
                                // If time is up, then go to gameOver
                                if (self.seconds == 0) {
                                    self.gameOverFunc()
                                }
                            }))
                            self.present(noCatch, animated: true, completion: {() -> Void in})
                        }
                    }
                    self.seconds2 -= 1
                }
            })
            // Calls displayFish
            displayFish()
            // Reset seconds2
            seconds2 = 1
        }
    }
    
    // Function that displays a fish on screen if it wasn't caught
    func displayFish() {
        // If the user guessed wrong then display where the fish is on the grid
        if (self.sea.checkFishCaught(cellPosition: self.cellPosition) == nil) {
            // Traverse rows
            for row in 0..<self.sea.n {
                // Traverse cols
                for col in 0..<self.sea.n {
                    // If there is a fish
                    if (self.sea.grid[row][col].fish != nil) {
                        // Make a variable for its location
                        let anotherPos: (Int, Int) = (row,col)
                        // If the position is the first button display the fish
                        if (anotherPos == (0,0)) {
                            self.buttons[0].setTitle("\(String(self.sea.grid[row][col].fish!))", for: UIControl.State.normal)
                        }
                        // If the position is the second button display the fish
                        if (anotherPos == (0,1)) {
                            self.buttons[1].setTitle("\(String(self.sea.grid[row][col].fish!))", for: UIControl.State.normal)
                        }
                        // If the position is the third button display the fish
                        if (anotherPos == (1,0)) {
                            self.buttons[2].setTitle("\(String(self.sea.grid[row][col].fish!))", for: UIControl.State.normal)
                        }
                        // If the position is the fourth button display the fish
                        if (anotherPos == (1,1)) {
                            self.buttons[3].setTitle("\(String(self.sea.grid[row][col].fish!))", for: UIControl.State.normal)
                        }
                    }
                }
            }
        }
        // Set Cast to false
        self.wasCast = false
    }
    
    // Function that resets the timer
    func stopTimer() {
        // Stop the timer
        timer?.invalidate()
        // Set timer to nil
        timer = nil
    }
    
    // Function that resets timer2
    func stopTimer2() {
        // Stop the timer
        timer2?.invalidate()
        // Set timer to nil
        timer2 = nil
    }
    
    // Function that updates user's score
    func updateScore(fish: String?) {
        // If there is a fish
        if (fish != nil) {
            // Set a variable to the fish so we can get the key later
            let potentialFishScore: String = fish!
            // If the Fish is a wave or nothing then return
            if (potentialFishScore == "🌊" || potentialFishScore == "") {
                return
            }
            // There is a fish
            else {
                // Set a variable for the fish score
                let fishScore: Int = sea.availableFish["\(potentialFishScore)"]!
                // Increment the score
                self.score += fishScore
                // Update the scoreLabel
                scoreLabel.text = "\(self.score)"
            }
        }
    }
    
    // Function that handles when the stepper is pressed
    @IBAction func stepperPressed(_ sender: UIStepper) {
        self.totalSeconds = Int(sender.value)
        totalSecondsLabel.text = ("Total: \(totalSeconds)s")
    }
    
    // Function to handle when the New Game button is Pressed
    @IBAction func newGamePressed(_ sender: UIButton) {
        // Stop the Timer
        self.stopTimer()
        // Reset the button titles to normal
        for button in 0..<count {
            buttons[button].setTitle("", for: UIControl.State.normal)
        }
        // Clear out the lines and sets fish to nil
        for row in 0..<sea.n {
            for col in 0..<sea.n {
                sea.grid[row][col].containsLine = false
            }
        }
        // Set wasCast to True
        wasCast = false
        // Go to gameOver
        self.gameOverFunc()
    }
    
    // Function to end the game and have the user play again
    // When Okay is pressed, the user is prepped and the game restarts
    func gameOverFunc() {
        let gameOver = UIAlertController(title: "Game Over", message: "You scored: \(score)", preferredStyle: .alert)
        // Action for when the Okay button is pressed
        gameOver.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action) -> Void in
            self.seconds = self.totalSeconds
            self.seconds2 = 1
            self.stopTimer()
            self.stopTimer2()
            self.score = 0
            self.scoreLabel.text = "0"
            self.prepUser()
        }))
        present(gameOver, animated: true, completion: { () -> Void in })
    }
}
