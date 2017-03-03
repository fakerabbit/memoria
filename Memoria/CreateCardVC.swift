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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
