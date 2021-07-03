//
//  ViewController.swift
//  FModDemo
//
//  Created by joker on 2018/11/28.
//  Copyright © 2018 joker. All rights reserved.
//

import UIKit
import OrzFMod

class ViewController: UIViewController {

    let player = FModCapsule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testFilePath = Bundle.main.path(forResource: "test", ofType: "xm")
        player.playStream(withFilePath: testFilePath)
        
        
    }


}

