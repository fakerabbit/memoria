//
//  PlainBtn.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class PlainBtn: UIButton {
    
    var title: String! {
        didSet {
            self.setTitle(title, for: .normal)
            self.sizeToFit()
        }
    }
    
    var makeSmall: Bool! {
        didSet {
            if makeSmall == true {
                self.setTitleColor(Utils.backgroundColor(), for: .normal)
                self.setTitleColor(Utils.cardColor(), for: .highlighted)
                self.titleLabel?.font = Utils.buttonSmallerFont()
            }
            else {
                self.setTitleColor(Utils.textColor(), for: .normal)
                self.setTitleColor(Utils.blueShadowColor(), for: .highlighted)
                self.titleLabel?.font = Utils.buttonSmallFont()
            }
        }
    }
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setTitleColor(Utils.textColor(), for: .normal)
        self.setTitleColor(Utils.blueShadowColor(), for: .highlighted)
        self.titleLabel?.font = Utils.buttonSmallFont()
        self.titleLabel?.contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
