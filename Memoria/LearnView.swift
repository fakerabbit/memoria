//
//  SplashView.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 2/8/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

class LearnView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var gradientLayer: CAGradientLayer! = {
        let view = CAGradientLayer()
        view.frame = CGRect.zero
        view.colors = self.lastColors
        return view
    }()
    
    lazy var collectionView: UICollectionView! = {
        let frame = self.frame
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1.0
        let cv: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.register(LearnCell.classForCoder(), forCellWithReuseIdentifier: "learnCell")
        return cv
    }()
    
    var categories: [Category]! {
        didSet {
            if categories == nil || categories.count == 0 {
                debugPrint("WARNING categories is null")
                return
            }
            self.collectionView.reloadData()
        }
    }
    
    private var lastColors: [CGColor]!
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = Utils.backgroundColor()
        
        self.lastColors = self.randomColors()
        self.layer.addSublayer(gradientLayer)
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        let pad: CGFloat = 100
        gradientLayer.frame = self.bounds
        collectionView.frame = CGRect(x: 0, y: pad, width: w, height: h - pad)
    }
    
    /*
     * MARK:- CollectionView Datasource & Delegate
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //debugPrint("count: \(categories.count)")
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let category = self.categories[indexPath.row]
        
        let cell:LearnCell = collectionView.dequeueReusableCell(withReuseIdentifier: "learnCell", for: indexPath) as! LearnCell
        cell.text = category.name
        cell.cellWidth = category.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var category:Category? = categories[indexPath.row]
        let pad: CGFloat = 100
        var size = CGSize(width: collectionView.frame.size.width - pad, height: 50)
        if category != nil {
            if let text: String = category!.name {
                let label = RoundTextView(frame: CGRect.zero)
                label.font = Utils.mainFont()
                label.text = text
                label.sizeToFit()
                size = label.sizeThatFits(CGSize(width: collectionView.frame.size.width/2.5, height: CGFloat.greatestFiniteMagnitude))
                if size.width > size.height {
                    size.height = size.width
                }
                else {
                    size.width = size.height
                }
                category?.width = size.width
                categories[indexPath.row] = category!
                size.width = collectionView.frame.size.width - pad
            }
        }
        
        return size
    }
    
    // MARK:- Animations
    
    func randomColors() -> [CGColor] {
        let colors = [Utils.darkColor().cgColor, Utils.backgroundColor().cgColor, Utils.blueShadowColor().cgColor]
        return colors.shuffled()
    }
    
    func backgroundAnim() {
        let timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] (timer) in
            
            let fromColors = self?.lastColors
            let colors = self?.randomColors()
            self?.lastColors = colors
            self?.gradientLayer.colors = colors
            let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = colors
            animation.duration = 4.0
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            self?.gradientLayer.add(animation, forKey:"animateGradient")
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
}
