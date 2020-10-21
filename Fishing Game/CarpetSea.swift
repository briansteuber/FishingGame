//
//  CarpetSea.swift
//  Fishing Game
//
//  Created by Steuber, Brian William on 10/19/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import Foundation

// implemention consultant intern
// zagignite

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
        // String representation
        var gridValues = ""
        // Nested Loop
        for row in 0..<n {
            for col in 0..<n {
                gridValues += grid[row][col].description + ", "
            }
        }
        return gridValues
    }
    
    // Initializer for a CarpetSea object
    init(n: Int) {
        self.n = n
        self.availableFish = ["🐟": 1, "🦀":5, "🐙":10, "🐬":15, "🦈":20]
        for numRows in 0..<n {
            var row = [Cell]()
            for numCols in 0..<n {
                row.append(Cell(row: numRows, col: numCols, containsLine: false, fish: nil))
                self.grid.append(row)
            }
        }
    }
    
    // Randomly selects a cell and places a random fish from the availableFish in the cell
    func randomlyPlaceFish() {
        var randomGeneratedFish = ""
        let cellRow = Int.random(in: 0..<n)
        let cellCol = Int.random(in: 0..<n)
        let randIndex = Int.random(in: 0...4)
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
        grid[cellRow][cellCol].fish = randomGeneratedFish
    }
    
    // Accepts the location of the user's fishing line and marks the cell as containing the line
    func dropFishingLine(cellPosition: (Int, Int)) {
        grid[cellPosition.0][cellPosition.1].containsLine = true
    }
    
    // If the cell containing the line also contains a fish, return the fish, otherwise return nil
    func checkFishCaught(cellPosition: (Int, Int)) -> String? {
        let potentialCatch = grid[cellPosition.0][cellPosition.1].fish
        if (grid[cellPosition.0][cellPosition.1].containsLine && potentialCatch != nil) {
            return grid[cellPosition.0][cellPosition.1].fish
        }
        else {
            return nil
        }
    }
}
