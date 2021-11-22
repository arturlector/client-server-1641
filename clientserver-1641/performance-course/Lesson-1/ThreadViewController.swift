//
//  ThreadViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 22.11.2021.
//

import UIKit

class ThreadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //memoryOverflow()
        
        //timerWithDate()
        
        //mainThread()
        
        runLoopInThreads()
    }
    
    func runLoopInThreads() {

        //Отдельный поток
        class TimeThread: Thread {
            override func main() {
                // Настраиваем таймер
 
                //RunLoop спит
                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                    print("Tick")
                }
                RunLoop.current.run() //просыпается
            }
        }
        
        let thread = TimeThread() //Создали объект потока
        thread.start() //
        
        //Отдельный поток
        Thread.detachNewThread {
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
                print("Tick")
            }
            //RunLoop.current.run() //просыпается
            RunLoop.current.run(until: Date() + 20) //через 20 секунд
        }
    }
    
    func mainThread() {
        
        //Отдельный поток
        Thread.detachNewThread {
            for _ in (0..<1000) {
            print("😈")
            }
        }
        
        //Отдельный поток
        let thread1 = Thread {
            for _ in (0..<1000) {
            print("🤡")
            }
        }
        thread1.qualityOfService = .userInteractive
        thread1.start()
 
    
        //Главный поток
        for _ in (0..<1000) {
            print("😇")
        }
    }
    

    func timerWithDate() {
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            print(Date())
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            sleep(1)
        }
    }
    
    func memoryOverflow() {
        
        print("start test")
        for index in 0...UInt.max {
            autoreleasepool {
                let string = NSString(format: "test + %d", index)
                print(string)
            } //
          
        }
        print("end test")
    }

}
