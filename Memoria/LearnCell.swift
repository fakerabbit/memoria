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
    
    typealias LearnCellOnTouch = (Category) -> Void
    var onTouch: LearnCellOnTouch = { category in }
    
    var text:String! {
        didSet {
            //debugPrint("text didSet: ", text)
            self.textView.textView.text = text
            self.textView.textView.sizeToFit()
            self.setNeedsLayout()
        }
    }
    
    var cellWidth:CGFloat! {
        didSet {
            self.layoutSubviews()
        }
    }
    
    var category: Category!
    
    private let textView: CircleTextView = CircleTextView(frame: CGRect.zero)
    internal lazy var button:UIButton! = {
        let b = UIButton(type: .custom)
        b.addTarget(self, action: #selector(onTouchDown(_:)), for: .touchDown)
        b.addTarget(self, action: #selector(onTouchUp(_:)), for: .touchUpInside)
        b.addTarget(self, action: #selector(onTouchUp(_:)), for: .touchDragExit)
        return b
    }()
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.contentView.backgroundColor = UIColor.red
        self.contentView.addSubview(textView)
        self.contentView.addSubview(button)
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
        textView.frame = CGRect(x: x, y: 0, width: cellWidth - 5, height: h - 5)
        button.frame = textView.frame
    }
    
    // MARK:- Private
    
    func onTouchDown(_ sender : UIButton) {
        self.textView.textView.textColor = Utils.cardColor()
        self.textView.layer.borderColor = Utils.cardColor().cgColor
    }
    
    func onTouchUp(_ sender : UIButton) {
        self.textView.textView.textColor = Utils.cardColor()
        self.textView.layer.borderColor = Utils.cardColor().cgColor
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] (timer) in
            
            self?.textView.textView.textColor = Utils.textColor()
            self?.textView.layer.borderColor = Utils.textColor().cgColor
            self?.onTouch((self?.category)!)
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
}
