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
    
    private var currentCard: Card!
    private var testCards:[Card?]! = []
    
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
        
        self.testCards = cards.shuffled()
        currentCard = self.testCards.first!
        self.testView.title = "Question"
        self.testView.frontCard.text = currentCard.question
        self.testView.backCard.text = currentCard.answer
    }
    
    func onDifficulty(_ sender: UIButton) {
        
        DataMgr.sharedInstance.evaluateCard(card: currentCard, difficulty: sender.tag, testCards: testCards) { [weak self] updatedCards in
            
            if updatedCards.count > 0 {
                self?.testView.onNextCard()
                self?.currentCard = updatedCards.first!
                self?.testCards = updatedCards.shuffled()
                self?.testView.title = "Question"
                self?.testView.frontCard.text = self?.currentCard.question
                self?.testView.backCard.text = self?.currentCard.answer
            }
            else {
                self?.testView.onNextCard()
                self?.testCards = updatedCards.shuffled()
                self?.testView.title = "Test completed"
                self?.testView.frontCard.text = "Congrats!"
                self?.testView.backCard.text = nil
                self?.testView.showAnswerBtn.title = "Done"
            }
        }
    }
}
