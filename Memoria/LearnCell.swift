//
//  LearnCell.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/2/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class LearnCell: UICollectionViewCell {
    
    var text:String! {
        didSet {
            //debugPrint("text didSet: ", text)
            if text != nil {
                self.textView.isHidden = false
            }
            else {
                self.textView.isHidden = true
            }
            self.textView.text = text
            self.textView.sizeToFit()
            self.setNeedsLayout()
        }
    }
    
    var cellWidth:CGFloat! {
        didSet {
            self.layoutSubviews()
        }
    }
    
    private let textView: RoundTextView = RoundTextView(frame: CGRect.zero)
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.contentView.backgroundColor = UIColor.red
        self.contentView.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w:CGFloat = self.frame.size.width
        let h:CGFloat = self.frame.size.height
        let x:CGFloat = Utils.randomBetweenNumbers(firstNum: 0, secondNum: w - cellWidth)
        textView.frame = CGRect(x: x, y: 0, width: cellWidth, height: h)
    }
}
