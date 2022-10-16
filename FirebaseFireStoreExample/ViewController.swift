//
//  ViewController.swift
//  FirebaseFireStoreExample
//
//  Created by sweta makuwala on 25/09/22.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    let dataBase = Firestore.firestore()
    @IBOutlet weak var textFld: UITextField!
    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFld.delegate = self
        let docRef = dataBase.document("iosacademy/example")
        docRef.addSnapshotListener { snapShot, error in
                        guard let data = snapShot?.data(), error == nil else { return }
                        guard let text = data["text"] as? String else { return}
                        DispatchQueue.main.async { [weak self] in
                            self?.lbl.text = text
                        }
            
                        print(data)
        }
//        docRef.getDocument { snapShot, error in
//            guard let data = snapShot?.data(), error == nil else { return }
//            guard let text = data["text"] as? String else { return}
//            DispatchQueue.main.async { [weak self] in
//                self?.lbl.text = text
//            }
//
//            print(data)
//        }
        
        
       
    }

    func saveData(text: String){
        // ios academy:
        let docRef = dataBase.document("iosacademy/example")
        docRef.setData(["text" : text])
        // chris:
        /*
         
         dataBase.collection("iosacademy").document("example").setData(["text": text])
         
         1) adding document
         dataBase.collection("iosacademy").addDocument(data: ["year" : 2017,
         "type" : "bear",
         "label": text])
         */
        /*
         2) getting the document id
         let newDoc =   dataBase.collection("iosacademy").document()
         print("\(newDoc.documentID)")
         newDoc.setData(["year": 2017,
         "type": "gammy",
         "label": "cool",
         "id": newDoc.documentID])
         */
        /* 3)adding a document with specific document id
         a).. make a new document
         dataBase.collection("iosacademy").document("bear-2017").setData(["test": "test"])
         b).. update already have document
         dataBase.collection("iosacademy").document("bear-2017").setData(["test": "abc"])
         dataBase.collection("iosacademy").document("bear-2017").setData(["copy": "xyz"])
         dataBase.collection("iosacademy").document("bear-2017").setData(["copy": "xyz", "hey": "hello"], merge: true)
         */
      //  4).. use completion handler to detect errors
        /* 5). delete a field
         dataBase.collection("iosacademy").document("bear-2017").updateData(["copy": FieldValue.delete()]) { error in
         return
         }
         */
        /* 6). delete a document
         dataBase.collection("iosacademy").document("bear-2017").delete()
         //7) delete with completion handler
         // 8) read with specific document
         dataBase.collection("iosacademy").document("bear-2017").getDocument { snapShot, error in
         if error == nil && snapShot != nil{
         print(snapShot?.documentID)
         }else {
         print(error?.localizedDescription)
         }
         }
         */
        /*
         //9) getting all documents from collection
         dataBase.collection("iosacademy").getDocuments { snapShot, error in
         if error == nil && snapShot != nil {
         for doc in snapShot!.documents {
         let docData = doc.data()
         print("docdata: \(docData)")
         }
         }
         }
         */
        /*
         10) getting a subset of documents:
         use : dataBase.collection("iosacademy").whereField(
         */
        
        
    }

}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let text = textField.text , !text.isEmpty {
            saveData(text: text)
        }

        return true
    }
}
