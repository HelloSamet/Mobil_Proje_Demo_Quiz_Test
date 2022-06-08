//
//  RegisterPage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class RegisterPage: UIViewController {
    
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var singinBtn: UIButton!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SingInButton(_ sender: Any) {
        let name = nameTxt.text!
        let email = emailTxt.text!
        let password = passwordTxt.text!
        
        if(name.isEmpty && email.isEmpty && password.isEmpty){
           AlertCikar(mesaj: "Lutfen Gerekli alanları Doldurunuz!")
        }else{
            CreateUser(email: email, password: password, _name: name)
        }
    }
    
    func BackPress(){
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "viewController") as! LoginPage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    
    
    func AlertCikar(mesaj: String){
        let alertControl = UIAlertController(title: "Uyari", message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        alertControl.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertControl, animated: true, completion: nil)
    }
    
    func CreateUser(email: String, password: String, _name: String){
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [self] authResult, error in
            if error != nil
            {
                self.AlertCikar(mesaj: "Hata!")
            }else
            {
                self.db.collection("Users").document((authResult?.user.email)!).setData(["Name" : nameTxt.text])
                self.AlertCikar(mesaj: "Kullanıcı Basarılı bir Sekilde Olusturuldu!")
                self.nameTxt.text = ""
                self.passwordTxt.text = ""
                self.emailTxt.text = ""
                BackPress()
                
            }

            })
        }

    
    
}
