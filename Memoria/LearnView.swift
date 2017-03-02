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
    
    lazy var gradientLayer: CAGradientLayer! = {
        let view = CAGradientLayer()
        view.frame = CGRect.zero
        view.colors = [Utils.darkColor().cgColor, Utils.backgroundColor().cgColor, Utils.blueShadowColor().cgColor]
        return view
    }()
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = Utils.backgroundColor()
        
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //let w = self.frame.size.width
        //let h = self.frame.size.height
        gradientLayer.frame = self.bounds
    }
}
