//
//  FavoritePage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 17.05.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseDatabase
import SwiftUI
class FavoritePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    let database = Firestore.firestore()
    @IBOutlet weak var AllWords: UITableView!
    var wordListArray = [String]()
    var meaningListArray = [String]()
    var documentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AllWords.dataSource = self
        AllWords.delegate = self
        getData()
    }
    
    
    // TableView Func
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllWords.dequeueReusableCell(withIdentifier: "wordss", for: indexPath) as! wordsCell
        cell.wordLbl.text = wordListArray[indexPath.row]
        cell.meaningLbl.text = meaningListArray[indexPath.row]
        cell.DocumentIdLbl.text = documentIdArray[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Firebase Kelimeler koleksiyonundaki verileri getiriyoruz.
    
    func getData(){
        database.collection("Data").addSnapshotListener { snapshot, error in
            if error != nil{
                
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.wordListArray.removeAll(keepingCapacity: false)
                    self.meaningListArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    
                    for doc in snapshot!.documents{
                        let documentID = doc.documentID
                        self.documentIdArray.append(documentID)
                        if let wordsss = doc.get("Word") as? String{
                            self.wordListArray.append(wordsss)
                        }
                        if let meaningsss = doc.get("Meaning") as? String {
                            self.meaningListArray.append(meaningsss)
                        }
                    }
                    self.AllWords.reloadData()
                }
                
            }
        }
    }
    
    
    
        
}
        
        
    
    

    


