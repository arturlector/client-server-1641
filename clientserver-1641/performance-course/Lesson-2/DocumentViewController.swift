//
//  DocumentViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 29.11.2021.
//

import UIKit

class DocumentStore: CustomStringConvertible {
    
    private var documents = [Document]()
    private let syncQueue = DispatchQueue(label: "DocumentStoreSyncQueue", attributes: .concurrent)
    
    func createDocumenet(fromName name: String) {
        syncQueue.async(flags: .barrier) {
            let lastId = self.documents.last?.id ?? 0
            let newId = lastId + 1
            let doc = Document(id: newId, name: name)
            self.documents.append(doc)
        }
    }
    
    func getDocument(byId id: Int) -> Document? {
        var document: Document?
        syncQueue.async(flags: .barrier) {
            if let index = self.documents.firstIndex(where: { $0.id == id }) {
                document = self.documents[index]
            }
        }
        return document
    }
    
    func getLastDocument() -> Document? {
        var document: Document?
        syncQueue.async(flags: .barrier) {
            document = self.documents.last
        }
        return document
    }
    
    func append(document: Document) {
        syncQueue.async(flags: .barrier) {
            self.documents.append(document)
        }
    }
    
    var description: String {
        var description = ""
        syncQueue.sync {
            description = self.documents.reduce("") { $0 + $1.description + ", " }
        }
        return description
    }
}

struct Document: CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String {
        return "\(id) - \(name)"
    }
}

class DocumentViewController: UIViewController {

    var documents: [Document] = []
    
    var documentStore = DocumentStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //maintThread()
        
        //dispatchGroup()
        
        documentService()
    }
    
    func documentService() {
        
        let firstChar = UnicodeScalar("А").value
        let lastChar = UnicodeScalar("Я").value
        let dispatchGroup = DispatchGroup()
        
        for charCode in firstChar...lastChar {
            DispatchQueue.global().async(group: dispatchGroup) {
                
                let docName = String(UnicodeScalar(charCode)!)
                self.documentStore.createDocumenet(fromName: docName)

//                let docName = String(UnicodeScalar(charCode)!)
//                let lastId = self.documentStore.getLastDocument()?.id ?? 0
//                let newId = lastId + 1
//                let doc = Document(id: newId, name: docName)
//                self.documentStore.append(document: doc)
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print(self.documentStore.description)
        }
        
    }
    
    func dispatchGroup() {
        
        let firstChar = UnicodeScalar("А").value
        let lastChar = UnicodeScalar("Я").value
        
        let dispatchGroup = DispatchGroup()
               
        for charCode in firstChar...lastChar {
            DispatchQueue.global().async(group: dispatchGroup) {
                print(Thread.current)
                let docName = String(UnicodeScalar(charCode)!)
                let lastId = self.documents.last?.id ?? 0
                let newId = lastId + 1
                let doc = Document(id: newId, name: docName)
                self.documents.append(doc)
            }
         }
                
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print(self.documents)
        }
        
    }
    
    func maintThread() {
        
        let firstChar = UnicodeScalar("А").value //1040...1071
        let lastChar = UnicodeScalar("Я").value //1071
        
        for charCode in firstChar...lastChar {
            let docName = String(UnicodeScalar(charCode)!) //Возвращаем в символ
            let lastId = documents.last?.id ?? 0
            let newId = lastId + 1
            let doc = Document(id: newId, name: docName)
            documents.append(doc)
        }
        print(documents)
    }
    


}
