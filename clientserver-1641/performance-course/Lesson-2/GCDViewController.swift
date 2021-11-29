//
//  GCDViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 25.11.2021.
//

import UIKit

class GCDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //globalAsyncSycncQosQueue()
        
        //mainQueueIsSerial()
        
        //globalQueueConcurrent()
        
        //customSerialQueue()
        
        //customConcurrentQueue()
        
        //dispatchGroupRequest(completion: () -> ())
    }
    
    func dispatchGroupRequest(completion:()->()) {
        
        let requestGroup = DispatchGroup()
        
        DispatchQueue.global().async(group: requestGroup) {
            //Парсим items
        }
        
        DispatchQueue.global().async(group: requestGroup) {
            //Парсим profiles
        }
        
        DispatchQueue.global().async(group: requestGroup) {
            //Парсим groups
        }
        
        requestGroup.notify(queue: DispatchQueue.main) {
            // Уже есть items, profiles, groups
            // Заранее собрать модель
            // completion([])
        }
    }
    
    func customConcurrentQueue() {
        
        let myQueue = DispatchQueue(label: "myQueue", attributes: .concurrent)
        myQueue.async {
            print(Thread.current)
            for _ in (0..<100) {
                print("😈")
            }
        }
        
        myQueue.async {
            print(Thread.current)
            for _ in (0..<100) {
                print("🤡")
            }
        }
    }
    
    //Именованная очередь - последовательная по умолчанию
    func customSerialQueue() {
        
        let myQueue = DispatchQueue(label: "myQueue")
        myQueue.async {
            print(Thread.current)
            for _ in (0..<100) {
                print("😈")
            }
        }
        
        myQueue.async {
            print(Thread.current)
            for _ in (0..<100) {
                print("🤡")
            }
        }
    }
    
    func mainQueueIsSerial() {
        
        //Последовательная очередь - 1 main thread - асинхронно
        DispatchQueue.main.async { print("H"); print(Thread.current)}
        DispatchQueue.main.async { print("e"); print(Thread.current)}
        DispatchQueue.main.async { print("l"); print(Thread.current)}
        DispatchQueue.main.async { print("l"); print(Thread.current)}
        DispatchQueue.main.async { print("o"); print(Thread.current)}
    }
    
    func globalQueueConcurrent() {
        
        //Задача ставиться в глобальная очередь
        DispatchQueue.global(qos: .userInteractive).async { print("H"); print(Thread.current) }
        DispatchQueue.global(qos: .userInitiated).async {sleep(1); print("e"); print(Thread.current) }
        
        
        DispatchQueue.global(qos: .utility).async {sleep(1); print("l"); print(Thread.current) }
        DispatchQueue.global(qos: .default).async { print("l"); print(Thread.current) }
        
        sleep(100)
        
        DispatchQueue.global(qos: .background).async { print("o"); print(Thread.current) }
    }
    
    func globalAsyncSycncQosQueue() {
        
        //1 поток
        
        //Стартует медленнее
        DispatchQueue.main.async {
            for _ in (0..<1000) {
                print(Thread.current)
                print("🎃")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for _ in (0..<1000) {
                print(Thread.current)
                print("😇")
            }
        }

        DispatchQueue.global().async {
            for _ in (0..<1000) {
                print(Thread.current)
                print("🤖")
            }
        }

        DispatchQueue.global(qos: .userInteractive).async {
            for _ in (0..<1000) {
                print(Thread.current)
                print("💀")
            }
        }
        
        //Паралленая очередь и ставим задачи на разные потоки
        DispatchQueue.global(qos: .background).sync {
            for _ in (0..<1000) {
                print(Thread.current)
                print("😈")
            }
        }
        
       
        
        
    }


}
