//
//  RoundTextView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/2/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

let kRoundTextInset: CGFloat = 5

class RoundTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
        self.backgroundColor = UIColor.clear
        self.textColor = Utils.orangeColor()
        self.font = Utils.mainFont()
        self.isScrollEnabled = false
        self.textAlignment = .center
        self.isUserInteractionEnabled = false
        self.textContainerInset = UIEdgeInsets(top: kRoundTextInset, left: kRoundTextInset, bottom: kRoundTextInset, right: kRoundTextInset)
        self.layer.masksToBounds = false;
        self.layer.borderWidth = 1
        self.layer.borderColor = Utils.orangeColor().cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.width/2;
        self.textContainerInset = UIEdgeInsets(top: self.frame.size.height/2.5, left: 0, bottom: 0, right: 0)
    }
}
