//
//  HomeThreePageViewController.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 22.05.2022.
//

import UIKit
import Firebase
class HomeThreePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    var myDocIDArray = [String]()
    var myWordArray = [String]()
    var myMeaningArray = [String]()
    
    
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        GetReadOrWriteData()

    }
    
    // table View fonksiyonları
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myDocIDArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myFavoriListCell") as! MyFavoriListTableViewCell
        cell.myWordLBL.text = self.myWordArray[indexPath.row]
        cell.myMeaningLBL.text = self.myMeaningArray[indexPath.row]
        cell.documentIDLBL.text = self.myDocIDArray[indexPath.row]
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func GetReadOrWriteData(){
        let email = FirebaseAuth.Auth.auth().currentUser?.email
        self.database.collection("Data").addSnapshotListener { snapshot, error in
            if snapshot?.isEmpty != true && snapshot != nil{
             
                self.myWordArray.removeAll(keepingCapacity: false)
                self.myMeaningArray.removeAll(keepingCapacity: false)
                self.myDocIDArray.removeAll(keepingCapacity: false)
                
                for doc in snapshot!.documents{
                    let dataID = doc.documentID
                    
                    self.database.collection(email!).addSnapshotListener { emailsnap, err in
                        if emailsnap?.isEmpty != true && emailsnap != nil{
                            
                           
                            
                            for document in emailsnap!.documents {
                                let docID = document.documentID
                                
                                
                                if dataID == docID {
                                    self.myDocIDArray.append(dataID)
                                    
                                    if let word = doc.data()["Word"] as? String{
                                        self.myWordArray.append(word)
                                    }
                                    if let meaning = doc.data()["Meaning"] as? String{
                                        self.myMeaningArray.append(meaning)
                                    }
                                }
                            }
                            
                            self.myTableView.reloadData()
                        }
                    }
                    
                }
                

            }
            self.myTableView.reloadData()
            
        }
        self.myTableView.updateConstraints()
            
    }
     
    
    
    // bütün kelimeleri gördüğümüz ekrana gidiyoruz
    
    @IBAction func GotoAllWordsPage(_ sender: Any) {
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "FavoritePage") as! FavoritePage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
