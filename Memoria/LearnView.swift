//
//  SplashView.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 2/8/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

class LearnView: UIView {
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Utils.backgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // let w = self.frame.size.width
        //let h = self.frame.size.height
    }
}
