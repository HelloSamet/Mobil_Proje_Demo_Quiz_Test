//
//  wordsCell.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 21.05.2022.
//

import UIKit
import Firebase
class wordsCell: UITableViewCell {
    
    @IBOutlet weak var wordLbl: UILabel!
    
    @IBOutlet weak var meaningLbl: UILabel!
    
    @IBOutlet weak var favsBtn: UIButton!
    
    @IBOutlet weak var DocumentIdLbl: UILabel!
    
    var myFavoriteWordArray = [String]()
    var myFavoriteMeaningArray = [String]()
    var myFavoriteIDArray = [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func FavsButtonGet(_ sender: Any) {
        let dID = DocumentIdLbl.text
        let firestoreDatabase = Firestore.firestore()
        let email = FirebaseAuth.Auth.auth().currentUser?.email
        
        firestoreDatabase.collection("Data").addSnapshotListener { [self] snapshot, error in
            if snapshot?.isEmpty != true && snapshot != nil{
                
                self.myFavoriteWordArray.removeAll(keepingCapacity: false)
                self.myFavoriteMeaningArray.removeAll(keepingCapacity: false)
                self.myFavoriteIDArray.removeAll(keepingCapacity: false)
                
                for doc in snapshot!.documents{
                    let documentID = doc.documentID
                    if documentID == dID{
                        self.myFavoriteIDArray.append(documentID)
                        if let wordsss = doc.get("Word") as? String{
                            self.myFavoriteWordArray.append(wordsss)
                        }
                        if let meaningsss = doc.get("Meaning") as? String {
                            self.myFavoriteMeaningArray.append(meaningsss)
                        }
                        
                        firestoreDatabase.collection(email!).document(documentID).setData(["Favorite" : true])
                    }
                }
                

            }
        }
    }
    
    
    
}




