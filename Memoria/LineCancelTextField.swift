//
//  LineCancelTextField.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/4/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class LineCancelTextField: UITextField {
    
    lazy var closeBtn: PlainBtn! = {
        let b = PlainBtn(frame: CGRect.zero)
        b.title = "X"
        b.makeSmall = true
        return b
    }()
    
    private let chatInset: CGFloat = 2
    private let topInset: CGFloat = 10
    
    private lazy var line:UIView! = {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = Utils.backgroundColor()
        return v
    }()
    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.font = Utils.mainFont()
        self.textColor = Utils.backgroundColor()
        self.returnKeyType = .next
        self.addSubview(line)
        self.addSubview(closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + chatInset, y: bounds.origin.y + topInset, width: bounds.size.width - chatInset * 2, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + chatInset, y: bounds.origin.y + topInset, width: bounds.size.width - chatInset * 2, height: bounds.size.height)
    }
    
    // MARK:- Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        line.frame = CGRect(x: 0, y: h, width: w, height: 1)
        closeBtn.frame = CGRect(x: w - h, y: 0, width: h, height: h)
    }
}
