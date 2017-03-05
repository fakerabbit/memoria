//
//  CreateCardView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CreateCardView: UIView, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    typealias CreateCardViewOnClose = (CreateCardView) -> Void
    var onClose: CreateCardViewOnClose = { view in }
    
    private var padY: CGFloat = 100.0
    private var isKeyboardShowing: Bool = false
    
    private lazy var titleLbl: UILabel! = {
       let lbl = UILabel(frame: CGRect.zero)
        lbl.font = Utils.logoFont()
        lbl.textColor = Utils.textColor()
        lbl.text = "Create Card"
        lbl.sizeToFit()
        lbl.frame.size.height += 5
        return lbl
    }()
    
    private lazy var closeBtn: PlainBtn! = {
       let b = PlainBtn(frame: CGRect.zero)
        b.title = "X"
        b.addTarget(self, action: #selector(onClose(_:)), for: .touchUpInside)
        return b
    }()
    
    lazy var card: CreateCard! = {
       let c = CreateCard(frame: CGRect.zero)
        c.qTfld.delegate = self
        c.aTfld.delegate = self
        c.catTfld.delegate = self
        c.catBtn.addTarget(self, action: #selector(onCategory(_:)), for: .touchUpInside)
        return c
    }()
    
    private lazy var gradientLayer: CAGradientLayer! = {
        let view = CAGradientLayer()
        view.frame = CGRect.zero
        view.colors = self.lastColors
        return view
    }()
    
    private lazy var picker: UIPickerView! = {
        let pick = UIPickerView(frame: CGRect.zero)
        pick.delegate = self
        pick.dataSource = self
        pick.isHidden = true
        pick.isUserInteractionEnabled = false
        return pick
    }()
    
    private var lastColors: [CGColor]!
    private let btnS: CGFloat = 50.0
    private var categories: [Category?] = []
    
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
        self.addSubview(picker)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidChangeStatusBarNotification(notification:)), name: .UIApplicationWillChangeStatusBarFrame, object: nil)
        
        DataMgr.sharedInstance.fetchCreateCategories() { categories in
            self.categories = categories
            let cat: Category = Category(name: "Add new category", width: 0)
            self.categories.append(cat)
        }
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
        gradientLayer.frame = self.bounds
        card.frame = CGRect(x: pad, y: padY, width: w - pad * 2, height: h - padY/2)
        closeBtn.frame = CGRect(x: w - (pad + btnS), y: padY - btnS, width: btnS, height: btnS)
        titleLbl.frame = CGRect(x: pad, y: closeBtn.frame.minY, width: titleLbl.frame.size.width, height: titleLbl.frame.size.height)
        picker.frame = CGRect(x: pad, y: h - picker.frame.size.height, width: w - pad * 2, height: picker.frame.size.height)
    }
    
    // MARK:- Private
    
    func showPicker(show: Bool) {
        picker.isHidden = show == false
        picker.isUserInteractionEnabled = show == true
        self.card.createBtn.isHidden = show
        self.card.createBtn.isUserInteractionEnabled = show == false
    }
    
    func onClose(_ sender : UIButton) {
        self.onClose(self)
    }
    
    func onCategory(_ sender : UIButton) {
        self.showPicker(show: picker.isHidden)
    }
    
    func onChooseCategory(category: Category) {
        self.card.catBtn.title = category.name
    }
    
    func onCreateCategory() {
        card.activateCatText(active: true)
        self.card.catBtn.isHidden = true
        self.card.catBtn.isUserInteractionEnabled = false
        self.card.createBtn.isUserInteractionEnabled = true
        self.card.createBtn.isHidden = false
        card.catTfld.becomeFirstResponder()
    }
    
    // MARK:- UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 1 {
            card.aTfld.becomeFirstResponder()
        }
        return true
    }
    
    // MARK:- UIPickerView methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let cat: Category = categories[row]!
        return cat.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        debugPrint("selected: \(categories[row]!.name)")
        if row == categories.count - 1 {
            self.onCreateCategory()
        }
        else {
            self.onChooseCategory(category: self.categories[row]!)
        }
        self.showPicker(show: false)
    }
    
    // MARK:- Keyboard notifications
    
    func updateCardPositions() {
        
        if isKeyboardShowing == false {
            //default position
            padY = 100
        }
        else {
            if card.qTfld.isFirstResponder == true {
                padY = 220
            }
            else if card.aTfld.isFirstResponder == true {
                padY = 120
            }
            else if card.catTfld.isFirstResponder == true {
                padY = 20
            }
            else {
                padY = 100
            }
        }
        //debugPrint("padY: \(padY)")
        self.layoutSubviews()
    }
    
    func keyboardWillShowNotification(notification: NSNotification) {
        
        isKeyboardShowing = !isKeyboardShowing
        updateCardPositions()
    }
    
    func keyboardWillHideNotification(notification: NSNotification) {
        
        isKeyboardShowing = !isKeyboardShowing
        updateCardPositions()
    }
    
    func applicationDidChangeStatusBarNotification(notification: NSNotification) {
        updateCardPositions()
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
