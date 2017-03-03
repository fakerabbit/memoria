//
//  CreateCard.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CreateCard: UIView {
    
    private lazy var qLbl: UILabel! = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.mainFont()
        lbl.textColor = Utils.backgroundColor()
        lbl.text = "Question"
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var qTfld: LineTextField! = {
       let tf = LineTextField(frame: CGRect.zero)
        return tf
    }()
    
    private lazy var aLbl: UILabel! = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.mainFont()
        lbl.textColor = Utils.backgroundColor()
        lbl.text = "Answer"
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var aTfld: LineTextField! = {
        let tf = LineTextField(frame: CGRect.zero)
        return tf
    }()
    
    private let pad: CGFloat = 20
    private let textFieldH: CGFloat = 40
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = Utils.blueShadowColor().cgColor
        self.layer.cornerRadius = 24.0
        self.clipsToBounds = true
        
        self.addSubview(qLbl)
        self.addSubview(qTfld)
        self.addSubview(aLbl)
        self.addSubview(aTfld)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        //let h = self.frame.size.height
        self.layer.shadowRadius = w/5.5
        qLbl.frame = CGRect(x: pad, y: pad, width: w - pad * 2, height: qLbl.frame.size.height)
        qTfld.frame = CGRect(x: qLbl.frame.minX, y: qLbl.frame.maxY + textFieldH/2, width: qLbl.frame.size.width, height: textFieldH)
        aLbl.frame = CGRect(x: qLbl.frame.minX, y: qTfld.frame.maxY + textFieldH, width: qLbl.frame.size.width, height: aLbl.frame.size.height)
        aTfld.frame = CGRect(x: qLbl.frame.minX, y: aLbl.frame.maxY + textFieldH/2, width: qLbl.frame.size.width, height: textFieldH)
    }
}
