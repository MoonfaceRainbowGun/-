//
//  ViewController.swift
//  🌚 🌈🔫🌝
//
//  Created by Lei Mingyu on 18/8/17.
//  Copyright © 2017 MFRG. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Config.testConfig()
        Config.testReadConfig()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

