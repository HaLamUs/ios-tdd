//
//  ViewController.swift
//  spyAsyncTest
//
//  Created by lamha on 15/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    private var service: Service!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Loading ..."
    }


}

