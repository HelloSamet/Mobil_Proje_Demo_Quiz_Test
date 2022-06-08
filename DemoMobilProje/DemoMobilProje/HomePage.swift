//
//  HomePage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit

class HomePage: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers = [HomeOnePage().self, HomeTwoPage().self, HomeThreePage().self, HomeFourPage().self]
        self.viewControllers = controllers.map{
            UINavigationController(rootViewController: $0)
        }
        
        
    }


}
