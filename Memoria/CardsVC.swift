//
//  CardsVC.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/5/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardsVC: MemoriaVC {
    
    var cards: [Card?]!
    var category: String!
    
    lazy var cardsView:CardsView! = {
        let frame = UIScreen.main.bounds
        let v = CardsView(frame: frame)
        return v
    }()
    
    override func loadView() {
        super.loadView()
        self.view = self.cardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardsView.backBtn.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        cardsView.catSwitch.addTarget(self, action: #selector(onCatSwitch(_:)), for: .valueChanged)
        cardsView.onCard = { [weak self] card in
            
            let vc = CardVC()
            vc.nav = self?.nav
            vc.card = card
            self?.present(vc, animated: true, completion: nil)
        }
        let card: Card = cards.first!!
        category = card.category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cat = Category(name: category, width: 0, active: true)
        DataMgr.sharedInstance.getCardsForCategory(category: cat) { [weak self] newCards in
            
            if newCards.count == 0 {
                _ = self?.nav?.popViewController(animated: true)
            }
            else {
                self?.cards = newCards
                self?.cardsView.cards = newCards
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Handlers
    
    func onCatSwitch(_ sender : UISwitch) {
        
        if cards.count > 0 {
            let card:Card = cards.first!!
            DataMgr.sharedInstance.updateCardStatusForCategory(category: card.category!, active: sender.isOn) { [weak self] updatedCards in
                self?.cardsView.cards = updatedCards
            }
        }
    }
    
    func onBack(_ sender : UIButton) {
        _ = self.nav?.popViewController(animated: true)
    }
}
