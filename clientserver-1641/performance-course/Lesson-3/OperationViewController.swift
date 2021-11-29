//
//  OperationViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 29.11.2021.
//

import UIKit

class OperationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //operationQueueCommonTask()
        
        //operationQueueConcurrent()
        
        operationBlockChain()
    }
    
    func operationBlockChain() {
        
        let queue = OperationQueue.main
        
        let operation1 = BlockOperation() {
            
            for i in 0..<100 {
                print("🤠\(i)")
                print(Thread.current)
            }
        }
        
        let operation2 = BlockOperation() {
            
            for i in 0..<100 {
                print("😈\(i)")
                print(Thread.current)
            }
        }
        
        let operation3 = BlockOperation() {
            
            for i in 0..<100 {
                print("👻\(i)")
                print(Thread.current)
            }
        }
        
        let finalOperation = BlockOperation() {
            
            for i in 0..<100 {
                print("😺\(i)")
                print(Thread.current)
            }
        }
        
        operation2.addDependency(operation1)
        operation3.addDependency(operation2)
        finalOperation.addDependency(operation3)
        
        let operations = [operation3, operation2, operation1, finalOperation]
        
        queue.addOperations(operations, waitUntilFinished: false)
    }
    
    func operationQueueCommonTask() {
        
        DispatchQueue.global().async {
            
            DispatchQueue.global().sync {
                
            }
        }
        
        
        let queue = OperationQueue()
        queue.addOperation {
            print(Thread.current)
            
            print("Тяжеловесная операция")
            
            OperationQueue.main.addOperation {
                    print("UI thread")
                    print(Thread.current)
            }
        }
    }
    
    func operationQueueConcurrent() {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 10 // можем сделать последовательной
        
        queue.addOperation {
            for i in 0..<1000 {
                print("🤠\(i)")
                print(Thread.current)
            }
        }
        
        queue.addOperation {
            for i in 0..<1000 {
                print("🤡\(i)")
                print(Thread.current)
            }
        }
        
        queue.addOperation {
            for i in 0..<1000 {
                print("🤖\(i)")
                print(Thread.current)
            }
        }
    }
    


}
