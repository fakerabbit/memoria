//
//  CircleTextView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CircleTextView: UIView {
    
    lazy var textView: UITextView! = {
       let textv = UITextView(frame: CGRect.zero, textContainer: nil)
        textv.backgroundColor = UIColor.clear
        textv.textColor = Utils.textColor()
        textv.font = Utils.mainFont()
        textv.isScrollEnabled = false
        textv.textAlignment = .center
        textv.isUserInteractionEnabled = false
        textv.textContainerInset = UIEdgeInsets.zero
        return textv
    }()
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1
        self.layer.borderColor = Utils.textColor().cgColor
        self.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        self.layer.cornerRadius = w/2
        let s: CGSize = textView.sizeThatFits(CGSize(width: w, height: h))
        textView.frame = CGRect(x: w/2 - s.width/2, y: h/2 - s.height/2, width: s.width, height: s.height)
    }
}
