//
//  ProblemsConcurrencyViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 02.12.2021.
//

import UIKit

class RaceCondition {
    
    private let threadSafeCountQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    private var _count = 0
    private var array = [Int]()
    
    let lock = NSLock()
    
    public func append(value: Int) {
        threadSafeCountQueue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [Int] {
        var result:[Int] = []
        threadSafeCountQueue.sync {
            result = self.array
        }
        return result
    }
    
    public var count: Int {
        get {
            lock.lock()
            var result = 0
            //threadSafeCountQueue.sync {
                result = self._count
            //}
            lock.unlock()
            return result
        }
        set {
            lock.lock()
            //threadSafeCountQueue.async(flags: .barrier) { [unowned self] in
                self._count = newValue
            //}
            lock.unlock()
        }
    }
}

class ProblemsConcurrencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        raceCondition()
    }
    
    func raceCondition() {
        let raceCondition = RaceCondition()
        
        //raceCondition.count += 1
        
        //NSThread/Thread
        let lock = NSLock()
        
        //GCD
        //100 url фотографий по 10 грузить одновременно в 10 потоках
        let semaphore = DispatchSemaphore(value: 1)
        
        let barrierQueue = DispatchQueue(label: "barrierQueue")
        
        
//        barrierQueue.async(flags: .barrier) {
//            //lock.lock()
//            //semaphore.wait() //один вошел подожди
//            raceCondition.count = raceCondition.count + 1
//            print(raceCondition.count)
//            //lock.unlock()
//            //semaphore.signal() // заходи
//        }
//
//        barrierQueue.async(flags: .barrier) {
//            //lock.lock()
//            //semaphore.wait()
//            raceCondition.count = raceCondition.count + 1
//            print(raceCondition.count)
//            //lock.unlock()
//            //semaphore.signal()
//        }
//
//        barrierQueue.async(flags: .barrier) {
//            //lock.lock()
//            //semaphore.wait()
//            raceCondition.count = raceCondition.count + 1
//            print(raceCondition.count)
//            //lock.unlock()
//            //semaphore.signal()
//        }
        
        DispatchQueue.concurrentPerform(iterations: 3) { index in
            raceCondition.count += 1
            print(raceCondition.count)
//
//            print(index)
//            raceCondition.append(value: index)
//            print(raceCondition.valueArray)
            
        }
        
        print(raceCondition.count)
        //print(raceCondition.valueArray)
        
        //print(raceCondition.count)
        
//        DispatchQueue.global(qos: .background).async {
//            print(raceCondition.count)
//        }
        
    }


}
