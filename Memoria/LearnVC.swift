//
//  SplashVC.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 2/8/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

class LearnVC: MemoriaVC {
    
    lazy var learnView:LearnView! = {
        let frame = UIScreen.main.bounds
        let v = LearnView(frame: frame)
        return v
    }()
    
    override func loadView() {
        super.loadView()
        self.view = self.learnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Utils.printFontNamesInSystem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
