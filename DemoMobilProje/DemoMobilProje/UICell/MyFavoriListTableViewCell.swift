//
//  MyFavoriListTableViewCell.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 22.05.2022.
//

import UIKit
import Firebase
class MyFavoriListTableViewCell: UITableViewCell {

    @IBOutlet weak var myWordLBL: UILabel!
    @IBOutlet weak var myMeaningLBL: UILabel!
    @IBOutlet weak var myFavsBTN: UIButton!
    @IBOutlet weak var documentIDLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func myClickedFavsButton(_ sender: Any) {
        let id = documentIDLBL.text
        let firestoreDatabase = Firestore.firestore()
        let email = FirebaseAuth.Auth.auth().currentUser?.email
        
        firestoreDatabase.collection(email!).addSnapshotListener { [self] snapshot, error in
            if snapshot?.isEmpty != true && snapshot != nil{

                for doc in snapshot!.documents{
                    let myFAvDataId = doc.documentID
                    if id == myFAvDataId{
                        firestoreDatabase.collection(email!).document(id!).delete()
                        
                    }
                }
                

            }
        }
    }
}
