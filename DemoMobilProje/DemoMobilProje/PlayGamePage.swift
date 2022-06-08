//
//  PlayGamePage.swift
//  DemoMobilProje
//
//  Created by Abdulsamet Göçmen on 23.05.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
class PlayGamePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    let database = Firestore.firestore()
    var dataBaseWordArray = [String]()
    var dataBaseMeaningArray = [String]()
    var dataBaseIDArray = [String]()
    var trueCount = 0
    var falseCount = 0
    var userScor = 0
    
    @IBOutlet weak var questionLBL: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    
    var gameModels = [Questions]()
    var currentQuestions: Questions?
    var indexArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTableView.delegate = self
        answerTableView.dataSource = self
        getData()
    }
    
    func getData(){
        self.database.collection("Data").addSnapshotListener { [self] snapshot, error in
            if error != nil{
                
            }else{
                if snapshot?.isEmpty != nil && snapshot != nil{
                    for doc in snapshot!.documents{
                        let docID = doc.documentID
                        self.dataBaseIDArray.append(docID)
                        if let word = doc.get("Word") as? String{
                            self.dataBaseWordArray.append(word)
                        }
                        if let meaning = doc.get("Meaning") as? String{
                            self.dataBaseMeaningArray.append(meaning)

                        }
                    }
                    for item in 0...15 {
                        self.gameModels.append(Questions(text:  self.dataBaseWordArray[item],
                         answers: [
                          Answer(text: self.dataBaseMeaningArray[item], correct: true),
                          Answer(text: self.dataBaseMeaningArray[item + 1], correct: false),
                          Answer(text: self.dataBaseMeaningArray[item + 2] , correct: false),
                          Answer(text: self.dataBaseMeaningArray[item + 3] , correct: false)
                          ]))
                    }
                    
                    configureUI(questions: gameModels.first!)
                   
                    
                    self.answerTableView.reloadData()
                }
            }
        }
       
    }
    

            
  
    
     
    
    

    
    // TableView fonksiyonlarımız
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestions?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = answerTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnswerCell
        cell.textLabel?.text = currentQuestions?.answers[indexPath.row].text
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        answerTableView.deselectRow(at: indexPath, animated: true)
        let question = currentQuestions
        let answer = question!.answers[indexPath.row]
        if checkAnswer(answer: answer, question: question!){
            if let index = gameModels.firstIndex(where: {$0.text == question?.text}){
                if index < (gameModels.count-1){
                    // next
                    
                    let nextQuestion = gameModels[index+1]
                    self.trueCount = self.trueCount + 1
                    print("True Count : \(self.trueCount)")
                    currentQuestions = nil
                    configureUI(questions: nextQuestion)
                }else{
                    // finish
                    self.AlertCikar(mesaj: "By By", title: "Finish")
                    goBack()
                    self.userScor = (self.trueCount-self.falseCount)*100
                    CreateScorsDatabase()
                    
                }
            }
        }else{
            if let index = gameModels.firstIndex(where: {$0.text == question?.text}){
                if index < (gameModels.count-1){
                    // next
                    
                    let nextQuestion = gameModels[index+1]
                    self.falseCount = self.falseCount + 1
                    print("False Count : \(self.falseCount)")
                    currentQuestions = nil
                    configureUI(questions: nextQuestion)
                }else{
                    // finish
                    self.AlertCikar(mesaj: "By By", title: "Finish")
                    goBack()
                    self.userScor = (self.trueCount-self.falseCount)*100
                    CreateScorsDatabase()
                    
                }
            }
        }
        
                
    }
    func goBack(){
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "HomeFourPage") as! HomeFourPage
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    // Soru İşlemlerimiz
    
    private func configureUI(questions: Questions){
        questionLBL.text = questions.text
        currentQuestions = questions
        answerTableView.reloadData()
        
    }
    
    private func checkAnswer(answer: Answer, question: Questions) -> Bool{
        if (answer.text == question.answers[0].text ){
           return true
        }else{
            return false
        }
        
    }
    
    // Alert Fonksiyonumuz
    
    func AlertCikar(mesaj: String, title: String){
        let alertControl = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        alertControl.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertControl, animated: true, completion: nil)
    }
    
    func CreateScorsDatabase(){
        let database = Firestore.firestore()
        let email = FirebaseAuth.Auth.auth().currentUser?.email
        
        database.collection("Users").addSnapshotListener { snapshot, error in
            if error != nil{
                self.AlertCikar(mesaj: "Hata", title: "Uyari")
            }else{
                for doc in snapshot!.documents {
                    if doc.documentID == email{
                        if let name = doc.data()["Name"]{
                            database.collection("Scors").addDocument(data: ["Name" : name, "Scor" : self.userScor])
                        }
                        
                    }
                }
            }
        }
        
    }
    
   
    

       

    
    

    
}

struct Questions{
    let text: String?
    let answers: [Answer]
}
struct Answer{
    let text: String?
    let correct: Bool?
}
