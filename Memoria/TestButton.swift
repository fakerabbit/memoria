//
//  TestButton.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class TestButton: UIButton {
    
    var title: String! {
        didSet {
            self.setTitle(title, for: .normal)
            self.sizeToFit()
            self.frame.size.width += 40
        }
    }
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Utils.blueShadowColor()
        self.layer.cornerRadius = 18.0
        self.layer.borderWidth = 1
        self.layer.borderColor = Utils.aquaColor().cgColor
        self.clipsToBounds = true
        self.setTitleColor(Utils.textColor(), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                self.backgroundColor = Utils.aquaColor()
            case false:
                self.backgroundColor = Utils.blueShadowColor()
            }
        }
    }
}
