//
//  CardsCell.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardsCell: UICollectionViewCell {
    
    var cardId:String!
    
    var text:String! {
        didSet {
            self.textView.text = text
            self.textView.sizeToFit()
            self.setNeedsLayout()
        }
    }
    
    var isActive: Bool! {
        didSet {
            self.cardSwitch.setOn(isActive, animated: true)
        }
    }
    
    lazy var cardSwitch:Switch! = {
       let s = Switch(frame: CGRect.zero)
        s.addTarget(self, action: #selector(onCatSwitch(_:)), for: .valueChanged)
        return s
    }()
    
    private lazy var textView: UITextView! = {
       let t = UITextView(frame: CGRect.zero, textContainer: nil)
        t.backgroundColor = UIColor.clear
        t.font = Utils.buttonSmallerFont()
        t.textColor = Utils.darkColor()
        t.isScrollEnabled = false
        t.isUserInteractionEnabled = false
        return t
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = Utils.textColor()
        self.layer.cornerRadius = 18.0
        self.clipsToBounds = true
        self.layer.borderColor = Utils.lightBorderColor().cgColor
        self.layer.borderWidth = 1.5
        
        self.addSubview(textView)
        self.addSubview(cardSwitch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w:CGFloat = self.frame.size.width
        let h:CGFloat = self.frame.size.height
        let switchS: CGFloat = self.frame.size.height/3
        textView.frame = CGRect(x: 0, y: 0, width: w, height: h - switchS)
        cardSwitch.frame = CGRect(x: w/2 - cardSwitch.frame.size.width/2, y: textView.frame.maxY - 5, width: cardSwitch.frame.size.width, height: cardSwitch.frame.size.height)
    }
    
    // MARK:- Handlers
    
    func onCatSwitch(_ sender : UISwitch) {
        
        DataMgr.sharedInstance.updateCardStatus(cardId: cardId, active: sender.isOn) { _ in
        }
    }
}
