//
//  HomeTwoPage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class HomeTwoPage: UIViewController {
    @IBOutlet weak var wordTxt: UITextField!
    @IBOutlet weak var meaningTxt: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let word = wordTxt.text!
        let meaning = meaningTxt.text!
        
        var ref: DocumentReference? = nil
        
        if word.isEmpty && meaning.isEmpty {
            self.AlertCikar(mesaj: "Lutfen Gerekli Alanları Doldurunuz!")
        }else{
            ref = db.collection("Data").addDocument(data: ["Word" : word, "Meaning" : meaning]){ [self] err in
                if let err = err {
                    self.AlertCikar(mesaj: "Error adding document : \(err)")
                }else{
                    self.AlertCikar(mesaj: "Document added with ID : \(ref?.documentID)")
                    self.wordTxt.text = ""
                    meaningTxt.text = ""
                }
            }
        }
    }
    
    func AlertCikar(mesaj: String){
        let alertControl = UIAlertController(title: "Uyari", message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        alertControl.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertControl, animated: true, completion: nil)
    }
    

}
