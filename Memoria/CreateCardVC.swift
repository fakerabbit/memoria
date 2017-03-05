//
//  CreateCardVC.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/3/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit

class CreateCardVC: UIViewController {
    
    lazy var createView:CreateCardView! = {
        let frame = UIScreen.main.bounds
        let v = CreateCardView(frame: frame)
        return v
    }()
    
    // MARK:- View methods
    
    override func loadView() {
        super.loadView()
        self.view = self.createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createView.backgroundAnim()
        createView.onClose = { [weak self] view in
            self?.dismiss(animated: true, completion: nil)
        }
        createView.card.qTfld.becomeFirstResponder()
        createView.card.createBtn.addTarget(self, action: #selector(onCreateCard(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Private
    
    func onCreateCard(_ sender : UIButton) {
        
        if (createView.card.qTfld.text?.characters.count)! <= 1 {
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                self.createView.card.qTfld.becomeFirstResponder()
            })
            let controller = UIAlertController(title: "Please add a Question", message: nil, preferredStyle: .alert)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
        else if (createView.card.aTfld.text?.characters.count)! <= 1 {
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                self.createView.card.aTfld.becomeFirstResponder()
            })
            let controller = UIAlertController(title: "Please add an Answer", message: nil, preferredStyle: .alert)
            controller.addAction(action)
            self.present(controller, animated: true, completion: nil)
        }
        else if createView.card.catTfld.isHidden == false {
            
            if (createView.card.catTfld.text?.characters.count)! <= 1 {
                let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                    self.createView.card.catTfld.becomeFirstResponder()
                })
                let controller = UIAlertController(title: "Please add a Category", message: nil, preferredStyle: .alert)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
            }
            else {
                let category:Category = Category(name: createView.card.catTfld.text, width: 0)
                DataMgr.sharedInstance.saveCategory(category: category) { [weak self] category in
                    let card = Card(question: (self?.createView.card.qTfld.text!)!, answer: self?.createView.card.aTfld.text, category: self?.createView.card.catBtn.title)
                    DataMgr.sharedInstance.saveCard(card: card) { [weak self] card in
                        if card == nil {
                            let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                            })
                            let controller = UIAlertController(title: "An error occurred :(", message: "Please try again", preferredStyle: .alert)
                            controller.addAction(action)
                            self?.present(controller, animated: true, completion: nil)
                        }
                        else {
                            self?.goToCardScreen()
                        }
                    }
                }
            }
        }
        else {
            let category:Category = Category(name: createView.card.catBtn.title, width: 0)
            DataMgr.sharedInstance.saveCategory(category: category) { [weak self] category in
                let card = Card(question: (self?.createView.card.qTfld.text!)!, answer: self?.createView.card.aTfld.text, category: self?.createView.card.catBtn.title)
                DataMgr.sharedInstance.saveCard(card: card) { [weak self] card in
                    if card == nil {
                        let action = UIAlertAction(title: "Ok", style: .destructive, handler: {(alert: UIAlertAction!) in
                        })
                        let controller = UIAlertController(title: "An error occurred :(", message: "Please try again", preferredStyle: .alert)
                        controller.addAction(action)
                        self?.present(controller, animated: true, completion: nil)
                    }
                    else {
                        self?.goToCardScreen()
                    }
                }
            }
        }
    }
    
    func goToCardScreen() {
        debugPrint("go to Card screen!")
    }
}
