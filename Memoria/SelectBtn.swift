//
//  SelectBtn.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class SelectBtn: UIButton {
    
    var title: String! {
        didSet {
            self.setTitle(title, for: .normal)
            self.sizeToFit()
        }
    }
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Utils.backgroundColor()
        self.layer.cornerRadius = 18.0
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                self.backgroundColor = Utils.cardColor()
            case false:
                self.backgroundColor = Utils.backgroundColor()
            }
        }
    }
}
