//
//  ViewController.swift
//  spyAsyncTest
//
//  Created by lamha on 15/03/2023.
//

import UIKit

public class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    private var service: Service!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Loading ..."
        service.load {
            [weak self] text in
//            DispatchQueue.main.async {
                self?.label.text = text
//            }
        }
    }
}

public extension ViewController {
    static func make(service: Service) -> ViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "ViewController") {
            let vc = ViewController(coder: $0)
            vc?.service = service
            return vc
        }
    }
    
}
