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
        self.testView.easyBtn.addTarget(self, action: #selector(onDifficulty(_:)), for: .touchUpInside)
        self.testView.goodBtn.addTarget(self, action: #selector(onDifficulty(_:)), for: .touchUpInside)
        self.testView.hardBtn.addTarget(self, action: #selector(onDifficulty(_:)), for: .touchUpInside)
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
        
        let card: Card? = self.cards.popLast()!
        self.testView.title = "Question"
        self.testView.frontCard.text = card?.question
        self.testView.backCard.text = card?.answer
    }
    
    func onDifficulty(_ sender: UIButton) {
        
        if self.cards.count > 0 {
            self.testView.onNextCard()
            let card: Card? = self.cards.popLast()!
            self.testView.title = "Question"
            self.testView.frontCard.text = card?.question
            self.testView.backCard.text = card?.answer
        }
        else {
            self.testView.onNextCard()
            self.testView.title = "Test completed"
            self.testView.frontCard.text = "Congrats!"
            self.testView.backCard.text = nil
            self.testView.showAnswerBtn.title = "Done"
        }
    }
}
