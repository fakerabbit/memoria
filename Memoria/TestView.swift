//
//  TestView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

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
    
    lazy var card: TestCard! = {
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
        let btnH: CGFloat = 50
        gradientLayer.frame = self.bounds
        card.frame = CGRect(x: pad, y: h/2 - cardH/2, width: w - pad * 2, height: cardH)
        closeBtn.frame = CGRect(x: w - (pad + btnS), y: card.frame.minY - btnS, width: btnS, height: btnS)
        titleLbl.frame = CGRect(x: pad, y: closeBtn.frame.midY - titleLbl.frame.size.height/2, width: closeBtn.frame.minX - pad, height: titleLbl.frame.size.height)
        showAnswerBtn.frame = CGRect(x: w/2 - showS/2, y: card.frame.maxY + 10, width: showS, height: btnH)
    }
    
    // MARK:- Private
    
    func onClose(_ sender : UIButton) {
        self.onClose(self)
    }
    
    func onShowAnswer(_ sender : UIButton) {
    }
    
    // MARK:- Animations
    
    func randomColors() -> [CGColor] {
        let colors = [Utils.aquaColor().cgColor, Utils.blueShadowColor().cgColor]
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
