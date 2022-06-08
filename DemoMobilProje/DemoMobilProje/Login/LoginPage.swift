//
//  LoginPage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginPage: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var singinBtn: UIButton!
    @IBOutlet weak var NavigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = emailTxt.text!
        let password = passwordTxt.text!
        
       OpenHome()
        
    }
    
    @IBAction func LogInButton(_ sender: Any) {
        let email = emailTxt.text!
        let password = passwordTxt.text!
        
        
        
        if(email.isEmpty && password.isEmpty){
            AlertCikar(mesaj: "Lutfen Gerekli Alanlari Doldurunuz!")
        }else{
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [self] user, error in
                if error != nil{
                    AlertCikar(mesaj: "Hata!")
                }else{
                    emailTxt.text = ""
                    passwordTxt.text = ""
                    OpenHome()
                }
            }
        }
    }
    
    
   
    
    @IBAction func SingInButton(_ sender: Any) {
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "registerPage") as! RegisterPage
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    func OpenHome(){
        if Auth.auth().currentUser != nil{
            let secondVC = storyboard!.instantiateViewController(withIdentifier: "HomePages") as! HomePages
            self.navigationController?.pushViewController(secondVC, animated: true)
            self.AlertCikar(mesaj: "Basarili")
        }else{
            self.AlertCikar(mesaj: "Boyle Bir Kullanici Bulunmamaktadir!")
        }
    }
   
    func AlertCikar(mesaj: String){
        let alertControl = UIAlertController(title: "Uyari", message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        alertControl.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertControl, animated: true, completion: nil)
    }
    
    
    

}


