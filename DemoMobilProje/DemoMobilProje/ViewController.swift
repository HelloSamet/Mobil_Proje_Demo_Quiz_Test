//
//  ViewController.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 14.05.2022.
//

import UIKit


class ViewController: UIViewController {
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    
    
    func AlertCikar(mesaj: String){
        let alertControl = UIAlertController(title: "Uyari", message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        alertControl.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertControl, animated: true, completion: nil)
    }
}

