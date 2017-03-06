//
//  CardsView.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/5/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    typealias CardsViewOnCard = (Card) -> Void
    var onCard: CardsViewOnCard = { card in }
    typealias CardsViewOnAdd = (CardsView) -> Void
    var onAdd: CardsViewOnAdd = { view in }
    
    
    var cards:[Card?]! {
        didSet {
            if cards.count > 0 {
                let card:Card = cards.first!!
                self.titleLbl.text = card.category
                self.titleLbl.sizeToFit()
                self.catSwitch.isOn = card.active
            }
            self.layoutIfNeeded()
            self.collectionView.reloadData()
        }
    }
    
    lazy var backBtn: UIButton! = {
       let b = UIButton(type: .custom)
        b.contentMode = .scaleAspectFit
        b.setImage(UIImage(named: "backIcon"), for: .normal)
        b.setImage(UIImage(named: "backIconSelected"), for: .highlighted)
        return b
    }()
    
    lazy var catSwitch:UISwitch! = {
        let s = UISwitch(frame: CGRect.zero)
        s.onTintColor = Utils.cardAlternateColor()
        s.backgroundColor = Utils.textColor()
        s.layer.cornerRadius = 16
        return s
    }()
    
    private lazy var gradientLayer: CAGradientLayer! = {
        let view = CAGradientLayer()
        view.frame = CGRect.zero
        view.colors = [Utils.blueShadowColor().cgColor, Utils.backgroundColor().cgColor]
        return view
    }()
    
    private lazy var collectionView: UICollectionView! = {
        let frame = self.frame
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        let cv: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = Utils.lightGrayColor()
        cv.alwaysBounceVertical = true
        cv.dataSource = self
        cv.delegate = self
        cv.register(CardsCell.classForCoder(), forCellWithReuseIdentifier: "cardsCell")
        cv.register(CardsHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "cardsHeader")
        return cv
    }()
    
    private lazy var titleLbl: UILabel! = {
       let l = UILabel(frame: CGRect.zero)
        l.font = Utils.boldFont()
        l.textColor = Utils.textColor()
        l.textAlignment = .center
        return l
    }()
    
    private let toolH:CGFloat = 45.0
    private let topPad: CGFloat = 25
    
    /*
     * MARK:- Init
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(gradientLayer)
        self.addSubview(collectionView)
        self.addSubview(titleLbl)
        self.addSubview(backBtn)
        self.addSubview(catSwitch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = self.frame.size.width
        let h = self.frame.size.height
        gradientLayer.frame = CGRect(x: 0, y: 0, width: w, height: toolH + topPad)
        backBtn.frame = CGRect(x: 0, y: topPad, width: toolH, height: toolH)
        catSwitch.frame = CGRect(x: w - (catSwitch.frame.size.width + 5), y: topPad + 5, width: catSwitch.frame.size.width, height: catSwitch.frame.size.height)
        collectionView.frame = CGRect(x: 0, y: toolH + topPad, width: w, height: h - (toolH + topPad))
        titleLbl.frame = CGRect(x: backBtn.frame.maxX, y: topPad, width: w - (toolH + catSwitch.frame.size.width), height: toolH)
    }
    
    /*
     * MARK:- CollectionView Datasource & Delegate
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let card = self.cards[indexPath.row]
        //debugPrint("cell card: \(card)")
        let cell:CardsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as! CardsCell
        cell.text = card?.question
        cell.isActive = card?.active
        cell.cardId = card?.id
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = self.cards[indexPath.row]
        self.onCard(card!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: collectionView.frame.size.width/3.5, height: collectionView.frame.size.width/3.5)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView: UICollectionReusableView?
        
        if kind == UICollectionElementKindSectionFooter {
            
            let header:CardsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "cardsHeader", for: indexPath) as! CardsHeader
            header.addBtn.addTarget(self, action: #selector(onAdd(_:)), for: .touchUpInside)
            reusableView = header
        }
        
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 100)
    }
    
    // MARK:- Private
    
    func onAdd(_ sender : UIButton) {
        self.onAdd(self)
    }
}
