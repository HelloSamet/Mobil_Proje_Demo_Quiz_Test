//
//  ExitViewController.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 20.05.2022.
//

import UIKit
import Firebase
class ExitViewController: UIViewController {

    @IBOutlet weak var ExitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ExitsUser(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            exit()
            
        }catch{
            print("error")
        }
        
        
    }
    
    func exit(){
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "viewController") as! LoginPage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
