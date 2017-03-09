//
//  NavController.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 1/16/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

class NavController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /*
     * CUSTOM NAVIGATION
     */
    
    func goToCardAfterCreate(vc: UIViewController, cards: [Card]) {
        vc.dismiss(animated: true, completion: {})
        self.navToCardsScreen(cards: cards)
    }
    
    func navToCardsScreen(cards: [Card?]) {
        let vc = CardsVC()
        vc.cards = cards
        self.pushViewController(vc, animated: true)
    }
    
    func startTest(for card:Card) {
        
        self.popToRootViewController(animated: false)
        let vc = TestVC()
        vc.nav = self
        vc.cards = [card]
        self.present(vc, animated: true, completion: nil)
    }
}
