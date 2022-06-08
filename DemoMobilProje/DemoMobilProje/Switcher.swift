import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController") as! LoginPage
        }else{
            
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "registerPage") as! RegisterPage
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
