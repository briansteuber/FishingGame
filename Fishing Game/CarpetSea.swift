//
//  CarpetSea.swift
//  Fishing Game
//  This class represents a CarpetSea in the CarpetSea game
//  Model in MVC
//  CPSC 315-02, Fall 2020
//  Programming Assignment #5
//  Sources: Piazza for help on initializing the grid, StackOverFlow for help with 2D arrays for passing a location
//  Extra Credit Completed
//
//  Created by Steuber, Brian William on 10/19/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import Foundation

// CarpetSea class
class CarpetSea: CustomStringConvertible {
    // Represents the dimension of the board
    var n: Int
    // Represents the n x n grid
    var grid = [[Cell]]()
    // Represents the emojis of fish
    var availableFish: [String: Int]
    // Description of the CarpetSea
    var description: String {
        // String representation of the grid
        var gridValues = "\n"
        // Nested Loop to put values into gridValues
        for row in 0..<n {
            for col in 0..<n {
                gridValues += grid[row][col].description + "\n"
            }
        }
        return gridValues
    }
    
    // Initializer for a CarpetSea object
    init(n: Int) {
        self.n = n
        self.availableFish = ["🐟": 1, "🦀":5, "🐙":10, "🐬":15, "🦈":20]
        // Initializing an n by n grid
        for numRows in 0..<n {
            var aCell = [Cell]()
            for numCols in 0..<n {
                aCell.append(Cell(row: numRows, col: numCols, containsLine: false, fish: nil))
            }
            self.grid.append(aCell)
        }
    }
    
    // Randomly selects a cell and places a random fish from the availableFish in the cell
    func randomlyPlaceFish() {
        // Random Fish
        var randomGeneratedFish = ""
        // Random number for a cell's row
        let cellRow = Int.random(in: 0..<n)
        // Random number for a cell's col
        let cellCol = Int.random(in: 0..<n)
        // Random number for what fish is placed
        let randIndex = Int.random(in: 0...4)
        //Cases for placing a fish
        if (randIndex == 0) {
            randomGeneratedFish = "🐟"
        }
        if (randIndex == 1) {
            randomGeneratedFish = "🦀"
        }
        if (randIndex == 2) {
            randomGeneratedFish = "🐙"
        }
        if (randIndex == 3) {
            randomGeneratedFish = "🐬"
        }
        if (randIndex == 4) {
            randomGeneratedFish = "🦈"
        }
        // Make that random cell contain a random fish
        grid[cellRow][cellCol].fish = randomGeneratedFish
    }
    
    // Accepts the location of the user's fishing line and marks the cell as containing the line
    func dropFishingLine(cellPosition: (Int, Int)) {
        grid[cellPosition.0][cellPosition.1].containsLine = true
    }
    
    // If the cell containing the line also contains a fish, return the fish, otherwise return nil
    func checkFishCaught(cellPosition: (Int, Int)) -> String? {
        // Variable for the user's button they clicked
        let potentialCatch = grid[cellPosition.0][cellPosition.1].fish
        // Check to see if the line is dropped and if there is a fish in that cell
        if (grid[cellPosition.0][cellPosition.1].containsLine && potentialCatch != nil) {
            return grid[cellPosition.0][cellPosition.1].fish
        }
        else {
            return nil
        }
    }
}
