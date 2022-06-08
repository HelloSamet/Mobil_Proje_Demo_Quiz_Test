//
//  HomeThreePage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class HomeThreePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
     var myFavoriteWordArray = [String]()
     var myFavoriteMeaningArray = [String]()
     var myFavoriteDocumentID = [String]()
     var userDocumentID = [String]()
    
   
  
    
    
    
    @IBOutlet weak var FavoriPageButtonClick: UIButton!
    @IBOutlet weak var myFavoriWordTable: UITableView!
    
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFavoriWordTable.delegate = self
        myFavoriWordTable.dataSource = self
        
    }

    func userFavori(){
        let email = FirebaseAuth.Auth.auth().currentUser?.email
        self.database.collection(email!).getDocuments { snapshot, error in
            if error != nil
            {
                print(error)
            }else
            {
                for document in snapshot!.documents {
                    let myDocID = document.documentID
                    self.userDocumentID.append(myDocID)
                    print(myDocID)
                }
            
                
                }
                self.myFavoriWordTable.reloadData()
            
            }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func GotoFavoritePage(_ sender: Any) {
        self.GotoPage()
    }

    func GotoPage(){
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "FavoritePage") as! FavoritePage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
