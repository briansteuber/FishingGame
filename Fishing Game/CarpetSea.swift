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
    var grid: [[Cell]]
    // Represents the emojis of fish
    var availableFish: [String: Int]
    // Description of the CarpetSea
    var description: String {
        return ""
    }
    
    // Initializer for a CarpetSea object
    init(n: Int, grid: [[Cell]], availableFish: [String: Int]) {
        self.n = n
        self.grid = grid
        self.availableFish = availableFish
    }
    
    // Randomly selects a cell and places a random fish from the availableFish in the cell
    func randomlyPlaceFish() {
        
    }
    
    // Accepts the location of the user's fishing line and marks the cell as containing the line
    func dropFishingLine() {
        
    }
    
    // If the cell containing the line also contains a fish, return the fish, otherwise return nil
    func checkFishCaught() {
        
    }
}
