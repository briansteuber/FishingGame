//
//  Cell.swift
//  Fishing Game
//  This class represents a Cell in the CarpetSea game
//  Model in MVC
//  CPSC 315-02, Fall 2020
//  Programming Assignment #5
//  No sources to cite
//
//  Created by Steuber, Brian William on 10/19/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import Foundation

// Cell Class
class Cell: CustomStringConvertible {
    // Represents a row location on the grid
    var row: Int
    // Represents a column location on the grid
    var col: Int
    // Represents whether or not the cell contains the user's line
    var containsLine: Bool
    // Represents an emoji of the fish contained in the cell
    var fish: String?
    // Description of a Cell
    var description: String {
        return "\(fish ?? "🌊") located at \(row), \(col)"
    }
    
    // Initializer for Cell object
    init(row: Int, col: Int, containsLine: Bool, fish: String?) {
        self.row = row
        self.col = col
        self.containsLine = containsLine
        self.fish = fish
    }
}
