//
//  TestVC.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class TestVC: UIViewController {
    
    var nav:NavController?
    var cards:[Card?]!
    
    lazy var testView:TestView! = {
        let frame = UIScreen.main.bounds
        let v = TestView(frame: frame)
        return v
    }()
    
    // MARK:- View methods
    
    override func loadView() {
        super.loadView()
        self.view = self.testView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testView.backgroundAnim()
        testView.onClose = { [weak self] view in
            self?.dismiss(animated: true, completion: nil)
        }
        self.startTest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK:- Private
    
    private func startTest() {
        
        var testCards:[Card?] = self.cards.shuffled()
        let card: Card? = testCards.popLast()!
        self.testView.title = "Question"
        self.testView.card.text = card?.question
        
    }
}
