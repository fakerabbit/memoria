//
//  CircleBtn.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/2/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CircleBtn: UIButton {
    
    var title: String! {
        didSet {
            self.titleLbl.text = title
            self.titleLbl.sizeToFit()
            self.layoutIfNeeded()
        }
    }
    
    private lazy var titleLbl: UILabel! = {
       let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.buttonFont()
        lbl.textColor = Utils.darkColor()
        return lbl
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = Utils.cardColor().cgColor
        self.addSubview(titleLbl)
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
                self.backgroundColor = UIColor.white
            }
        }
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        self.layer.cornerRadius = w/2;
        self.layer.shadowRadius = w/2;
        titleLbl.frame = CGRect(x: w/2 - titleLbl.frame.size.width/2, y: h/2 - titleLbl.frame.size.height/2 + 5, width: titleLbl.frame.size.width, height: titleLbl.frame.size.height)
    }
}
