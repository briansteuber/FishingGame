//
//  ViewController.swift
//  Fishing Game
//
//  Created by Steuber, Brian William on 10/12/20.
//  Copyright © 2020 Steuber, Brian William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print("Button Pressed")
        // how do we know what button was pressed?
        // 2 ways
        // use an outlet connection
        print("tag: \(sender.tag)")
        /*
        if let senderIndex = buttons.firstIndex(of: sender) {
            print("Sender Index\(senderIndex)")
        }
        */
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

