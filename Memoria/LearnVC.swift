//
//  SplashVC.swift
//  LucasBot
//
//  Created by Mirko Justiniano on 2/8/17.
//  Copyright © 2017 LB. All rights reserved.
//

import Foundation
import UIKit

class LearnVC: MemoriaVC {
    
    lazy var learnView:LearnView! = {
        let frame = UIScreen.main.bounds
        let v = LearnView(frame: frame)
        return v
    }()
    
    override func loadView() {
        super.loadView()
        self.view = self.learnView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Utils.printFontNamesInSystem()
        learnView.backgroundAnim()
        learnView.onCell = { category in
            //debugPrint("category: \(category)")
            DataMgr.sharedInstance.getCardsForCategory(category: category) { [weak self] cards in
                if cards.count > 0 {
                    self?.nav?.navToCardsScreen(cards: cards)
                }
            }
        }
        learnView.onAdd = { [weak self] _ in
            
            let vc = CreateCardVC()
            vc.nav = self?.nav
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataMgr.sharedInstance.fetchCategories() { categories in
            
            self.learnView.categories = categories
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
