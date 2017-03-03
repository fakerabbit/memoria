//
//  CreateCardView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CreateCardView: UIView {
    
    typealias CreateCardViewOnClose = (CreateCardView) -> Void
    var onClose: CreateCardViewOnClose = { view in }
    
    private lazy var titleLbl: UILabel! = {
       let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.logoFont()
        lbl.textColor = Utils.textColor()
        lbl.text = "Create Card"
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var closeBtn: PlainBtn! = {
       let b = PlainBtn(frame: CGRect.zero)
        b.title = "X"
        b.addTarget(self, action: #selector(onClose(_:)), for: .touchUpInside)
        return b
    }()
    
    private lazy var card: CreateCard! = {
       let c = CreateCard(frame: CGRect.zero)
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
        self.addSubview(titleLbl)
        self.addSubview(card)
        self.addSubview(closeBtn)
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
        let padY: CGFloat = 100.0
        gradientLayer.frame = self.bounds
        card.frame = CGRect(x: pad, y: padY, width: w - pad * 2, height: h - padY/2)
        closeBtn.frame = CGRect(x: w - (pad + btnS), y: padY - btnS, width: btnS, height: btnS)
        titleLbl.frame = CGRect(x: pad, y: padY - (titleLbl.frame.size.height + 10), width: titleLbl.frame.size.width, height: titleLbl.frame.size.height)
    }
    
    // MARK:- Private
    
    func onClose(_ sender : UIButton) {
        self.onClose(self)
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
