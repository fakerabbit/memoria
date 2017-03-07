//
//  TestView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class TestView: UIView {
    
    typealias TestViewOnClose = (TestView) -> Void
    var onClose: TestViewOnClose = { view in }
    
    var title: String! {
        didSet {
            self.titleLbl.text = title
            self.titleLbl.sizeToFit()
            self.layoutIfNeeded()
        }
    }
    
    lazy var showAnswerBtn: TestButton! = {
       let b = TestButton(frame: CGRect.zero)
        b.title = "Show Answer"
        b.addTarget(self, action: #selector(onShowAnswer(_:)), for: .touchUpInside)
        return b
    }()
    
    lazy var easyBtn: TestButton! = {
        let b = TestButton(frame: CGRect.zero)
        b.title = "Easy"
        b.isHidden = true
        b.isUserInteractionEnabled = false
        b.tag = 1
        return b
    }()
    
    lazy var goodBtn: TestButton! = {
        let b = TestButton(frame: CGRect.zero)
        b.title = "Good"
        b.isHidden = true
        b.isUserInteractionEnabled = false
        b.tag = 2
        return b
    }()
    
    lazy var hardBtn: TestButton! = {
        let b = TestButton(frame: CGRect.zero)
        b.title = "Hard"
        b.isHidden = true
        b.isUserInteractionEnabled = false
        b.tag = 3
        return b
    }()
    
    private lazy var titleLbl: UILabel! = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.boldFont()
        lbl.textColor = Utils.textColor()
        return lbl
    }()
    
    private var padY: CGFloat = 100.0
    
    private lazy var closeBtn: PlainBtn! = {
        let b = PlainBtn(frame: CGRect.zero)
        b.title = "X"
        b.addTarget(self, action: #selector(onClose(_:)), for: .touchUpInside)
        return b
    }()
    
    lazy var frontCard: TestCard! = {
        let c = TestCard(frame: CGRect.zero)
        return c
    }()
    
    lazy var backCard: TestCard! = {
        let c = TestCard(frame: CGRect.zero)
        return c
    }()
    
    private lazy var card: TestCard! = {
        let c = TestCard(frame: CGRect.zero)
        return c
    }()
    
    private lazy var gradientLayer: CAGradientLayer! = {
        let view = CAGradientLayer()
        view.frame = CGRect.zero
        view.colors = self.lastColors
        return view
    }()
    
    private var lastColors: [CGColor]!
    private let btnS: CGFloat = 50.0
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.lastColors = self.randomColors()
        self.layer.addSublayer(gradientLayer)
        self.addSubview(card)
        self.addSubview(titleLbl)
        self.addSubview(closeBtn)
        self.addSubview(showAnswerBtn)
        self.addSubview(easyBtn)
        self.addSubview(goodBtn)
        self.addSubview(hardBtn)
        card.addSubview(frontCard)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        let pad: CGFloat = 30.0
        let cardH: CGFloat = h/2
        let showS: CGFloat = 140
        let smallBtnS: CGFloat = showS/2
        let btnH: CGFloat = 50
        gradientLayer.frame = self.bounds
        card.frame = CGRect(x: pad, y: h/2 - cardH/2, width: w - pad * 2, height: cardH)
        frontCard.frame = card.bounds
        backCard.frame = card.bounds
        closeBtn.frame = CGRect(x: w - (pad + btnS), y: card.frame.minY - btnS, width: btnS, height: btnS)
        titleLbl.frame = CGRect(x: pad, y: closeBtn.frame.midY - titleLbl.frame.size.height/2, width: closeBtn.frame.minX - pad, height: titleLbl.frame.size.height)
        showAnswerBtn.frame = CGRect(x: w/2 - showS/2, y: card.frame.maxY + 10, width: showS, height: btnH)
        goodBtn.frame = CGRect(x: w/2 - smallBtnS/2, y: showAnswerBtn.frame.minY, width: smallBtnS, height: btnH)
        easyBtn.frame = CGRect(x: w * 0.25 - smallBtnS/2, y: goodBtn.frame.minY, width: smallBtnS, height: btnH)
        hardBtn.frame = CGRect(x: goodBtn.frame.minX + (goodBtn.frame.minX - easyBtn.frame.minX), y: goodBtn.frame.minY, width: smallBtnS, height: btnH)
    }
    
    // MARK:- Private
    
    func onClose(_ sender : UIButton) {
        self.onClose(self)
    }
    
    func onShowAnswer(_ sender : UIButton) {
        
        if backCard.text == nil {
            self.onClose(self)
        }
        else {
            self.card.flipToView(frontCard: frontCard, backCard: backCard) { [weak self] finished in
                
                self?.title = "Answer"
                self?.showAnswerBtn.isHidden = true
                self?.showAnswerBtn.isUserInteractionEnabled = false
                self?.easyBtn.isHidden = false
                self?.easyBtn.isUserInteractionEnabled = true
                self?.goodBtn.isHidden = false
                self?.goodBtn.isUserInteractionEnabled = true
                self?.hardBtn.isHidden = false
                self?.hardBtn.isUserInteractionEnabled = true
            }
        }
    }
    
    func onNextCard() {
        
        self.card.animateCard(frontCard: backCard, backCard: frontCard, callback: { [weak self] finished in
            
            self?.showAnswerBtn.isHidden = false
            self?.showAnswerBtn.isUserInteractionEnabled = true
            self?.easyBtn.isHidden = true
            self?.easyBtn.isUserInteractionEnabled = false
            self?.goodBtn.isHidden = true
            self?.goodBtn.isUserInteractionEnabled = false
            self?.hardBtn.isHidden = true
            self?.hardBtn.isUserInteractionEnabled = false
        })
    }
    
    // MARK:- Animations
    
    func randomColors() -> [CGColor] {
        let colors = [Utils.cardColor().cgColor, Utils.cardAlternateColor().cgColor, Utils.backgroundColor().cgColor]
        return colors.shuffled()
    }
    
    func backgroundAnim() {
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] (timer) in
            
            let fromColors = self?.lastColors
            let colors = self?.randomColors()
            self?.lastColors = colors
            self?.gradientLayer.colors = colors
            let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = colors
            animation.duration = 2.0
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            self?.gradientLayer.add(animation, forKey:"animateGradient")
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
}
