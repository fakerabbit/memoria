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
        tf.tag = 1
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
        tf.tag = 2
        return tf
    }()
    
    private lazy var catLbl: UILabel! = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.mainFont()
        lbl.textColor = Utils.backgroundColor()
        lbl.text = "Category"
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var catBtn: SelectBtn! = {
        let btn = SelectBtn(frame: CGRect.zero)
        return btn
    }()
    
    lazy var createBtn: SelectBtn! = {
        let btn = SelectBtn(frame: CGRect.zero)
        btn.title = "Create Card"
        return btn
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
        self.addSubview(aLbl)
        self.addSubview(catLbl)
        self.addSubview(qTfld)
        self.addSubview(aTfld)
        self.addSubview(catBtn)
        self.addSubview(createBtn)
        
        DataMgr.sharedInstance.fetchFirstCategory() { category in
            self.catBtn.title = category.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        self.layer.shadowRadius = w/5.5
        qLbl.frame = CGRect(x: pad, y: pad, width: w - pad * 2, height: qLbl.frame.size.height)
        qTfld.frame = CGRect(x: qLbl.frame.minX, y: qLbl.frame.maxY + textFieldH/2, width: qLbl.frame.size.width, height: textFieldH)
        aLbl.frame = CGRect(x: qLbl.frame.minX, y: qTfld.frame.maxY + textFieldH, width: qLbl.frame.size.width, height: aLbl.frame.size.height)
        aTfld.frame = CGRect(x: qLbl.frame.minX, y: aLbl.frame.maxY + textFieldH/2, width: qLbl.frame.size.width, height: textFieldH)
        catLbl.frame = CGRect(x: qLbl.frame.minX, y: aTfld.frame.maxY + textFieldH, width: qLbl.frame.size.width, height: catLbl.frame.size.height + 5)
        catBtn.frame = CGRect(x: qLbl.frame.minX, y: catLbl.frame.maxY + textFieldH/2, width: qLbl.frame.size.width/2, height: textFieldH)
        createBtn.frame = CGRect(x: qLbl.frame.minX, y: catBtn.frame.maxY + textFieldH, width: qLbl.frame.size.width, height: textFieldH)
    }
}
