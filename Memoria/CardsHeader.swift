//
//  CardsHeader.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardsHeader: UICollectionReusableView {
    
    lazy var practiceBtn: BoldButton! = {
        let b = BoldButton(frame: CGRect.zero)
        b.title = "practice now"
        return b
    }()
    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(practiceBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        let btnS: CGFloat = 50
        practiceBtn.frame = CGRect(x: w/2 - practiceBtn.frame.size.width/2, y: h/2 - btnS/2, width: practiceBtn.frame.size.width, height: btnS)
    }
}
