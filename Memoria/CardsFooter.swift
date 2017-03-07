//
//  CardsHeader.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardsFooter: UICollectionReusableView {
    
    lazy var addBtn: CircleBtn! = {
        let btn = CircleBtn(frame: CGRect.zero)
        btn.title = "+"
        return btn
    }()
    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addSubview(addBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        let btnS: CGFloat = 70
        addBtn.frame = CGRect(x: w/2 - btnS/2, y: h/2 - btnS/2, width: btnS, height: btnS)
    }
}
