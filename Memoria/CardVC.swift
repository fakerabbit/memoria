//
//  CardVC.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/6/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CardVC: UIViewController {
    
    var nav:NavController?
    var card:Card!
    
    lazy var cardView:CardView! = {
        let frame = UIScreen.main.bounds
        let v = CardView(frame: frame)
        return v
    }()
    
    // MARK:- View methods
    
    override func loadView() {
        super.loadView()
        self.view = self.cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cardView.backgroundAnim()
        cardView.onClose = { [weak self] view in
            self?.dismiss(animated: true, completion: nil)
        }
        cardView.card.qTfld.text = card.question
        cardView.card.aTfld.text = card.answer
        cardView.card.catBtn.title = card.category
        cardView.card.createBtn.addTarget(self, action: #selector(onUpdateCard(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Private
    
    func onUpdateCard(_ sender : UIButton) {
        
        if (cardView.card.qTfld.text?.characters.count)! <= 1 {
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                self.cardView.card.qTfld.becomeFirstResponder()
            })
            let controller = UIAlertController(title: "Please add a Question", message: nil, preferredStyle: .alert)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
        else if (cardView.card.aTfld.text?.characters.count)! <= 1 {
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                self.cardView.card.aTfld.becomeFirstResponder()
            })
            let controller = UIAlertController(title: "Please add an Answer", message: nil, preferredStyle: .alert)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
        else if cardView.card.catTfld.isHidden == false {
            
            if (cardView.card.catTfld.text?.characters.count)! <= 1 {
                let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                    self.cardView.card.catTfld.becomeFirstResponder()
                })
                let controller = UIAlertController(title: "Please add a Category", message: nil, preferredStyle: .alert)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
            }
            else {
                let category:Category = Category(name: cardView.card.catTfld.text, width: 0, active: true)
                DataMgr.sharedInstance.saveCategory(category: category) { [weak self] category in
                    let newCard = Card(id: (self?.card.id)!, question: (self?.cardView.card.qTfld.text!)!, answer: self?.cardView.card.aTfld.text, category: category.name, active: (self?.card.active)!)
                    DataMgr.sharedInstance.updateCard(card: newCard) { [weak self] cardUpdated in
                        if cardUpdated == nil {
                            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                            })
                            let controller = UIAlertController(title: "An error occurred :(", message: "Please try again", preferredStyle: .alert)
                            controller.addAction(action)
                            self?.present(controller, animated: true, completion: nil)
                        }
                        else {
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        else {
            let category:Category = Category(name: cardView.card.catBtn.title, width: 0, active: true)
            DataMgr.sharedInstance.saveCategory(category: category) { [weak self] category in
                let newCard = Card(id: (self?.card.id)!, question: (self?.cardView.card.qTfld.text!)!, answer: self?.cardView.card.aTfld.text, category: category.name, active: (self?.card.active)!)
                DataMgr.sharedInstance.updateCard(card: newCard) { [weak self] cardUpdated in
                    if cardUpdated == nil {
                        let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                        })
                        let controller = UIAlertController(title: "An error occurred :(", message: "Please try again", preferredStyle: .alert)
                        controller.addAction(action)
                        self?.present(controller, animated: true, completion: nil)
                    }
                    else {
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
