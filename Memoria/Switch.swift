//
//  Switch.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class Switch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onTintColor = Utils.backgroundColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
