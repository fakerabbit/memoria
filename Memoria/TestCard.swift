//
//  TestCard.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class TestCard: UIView {
    
    var text: String! {
        didSet {
            textView.text = text
            textView.sizeToFit()
            self.layoutIfNeeded()
        }
    }
    
    private lazy var textView: UITextView! = {
       let t = UITextView(frame: CGRect.zero, textContainer: nil)
        t.backgroundColor = UIColor.clear
        t.font = Utils.cardFont()
        t.textColor = Utils.blueShadowColor()
        t.textAlignment = .center
        t.contentMode = .scaleAspectFit
        return t
    }()
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 24.0
        self.layer.borderColor = Utils.cardAlternateColor().cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        
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
        let textS: CGSize = textView.sizeThatFits(CGSize(width: w, height: h))
        self.textView.frame = CGRect(x: w/2 - textS.width/2, y: h/2 - textS.height/2, width: textS.width, height: textS.height)
    }
    
    // MARK:- Animations
    
    func flipToView(frontCard: TestCard, backCard: TestCard, callback: ((Bool) -> Void)?) {
        
        UIView.transition(from: frontCard, to: backCard, duration: 1.0, options: .transitionFlipFromRight, completion: callback)
    }
}
