//
//  HomeFourPage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 15.05.2022.
//

import UIKit
import Firebase
class HomeFourPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var userScorData = [Data]()
    var fakeData = Data(name: "", scor: 0)
    
    
    

    @IBOutlet weak var ScorListTableView: UITableView!
    @IBOutlet weak var playBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ScorListTableView.delegate = self
        ScorListTableView.dataSource = self
        getScorsData()
        // Do any additional setup after loading the view.
    }
    
    
    func getScorsData(){
        let database = Firestore.firestore()
        database.collection("Scors").addSnapshotListener { snapshot, error in
            if error != nil{
                
            }else{
                for doc in snapshot!.documents {
                    if let names = doc.data()["Name"]{
                        self.fakeData.name = names as! String
                    }
                    if let scors = doc.data()["Scor"]{
                        self.fakeData.scor = scors as! Int
                    }
                    self.userScorData.append(self.fakeData)
                    
                }
                self.ScorListTableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userScorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScorListTableView.dequeueReusableCell(withIdentifier: "scorCell") as! ScorCellTableViewCell
        cell.userScorLBL.text = "\(self.userScorData[indexPath.row].scor)"
        cell.usernameLBL.text = self.userScorData[indexPath.row].name
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    

    @IBAction func PlayButton(_ sender: Any) {
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "PlayGamePage") as! PlayGamePage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    
}
struct Data{
    var name: String
    var scor: Int
}
