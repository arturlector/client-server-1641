//
//  ConcurrencyTestsViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 02.12.2021.
//

import UIKit

class ConcurrencyTestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       testTask5()
    }
    
    func testTask5() {
        
        let queue = DispatchQueue(label: "com.imagedownloader")
        
        queue.async {
            print("1")
            print(Thread.current)
            //блок
            queue.sync {
                print("2")
                print(Thread.current)
            }
        }
        
    }
    

    func testTask1() {
        
        DispatchQueue.global().async {
            print("1")
            DispatchQueue.global().sync { //стопаем поток
                print("2")
                DispatchQueue.global().async {
                    print("3")
                }
                print("4")
            } //отпустили поток
            print("5")
        }
        print("6")
        
        //6 5 4 2 3 1
    }
    
    func testTask2() {
        
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            DispatchQueue.main.async {
                print("C")
            }
            DispatchQueue.main.async {
                print("D")
            }
            DispatchQueue.global().sync {
                print ("E")
            }
        }
        print("F")
        DispatchQueue.main.async {
            print("G")
        }
        
        //A B D C
        
    }
    
    func testTask4() {
        
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            
            DispatchQueue.main.async {
                print("С")
                
                DispatchQueue.main.async {
                    print("D")
                    
                    DispatchQueue.main.async {
                        print("E")
                    }
                }
            }
            
            DispatchQueue.global().sync { //контекст - 1 поток
                print(Thread.current)
                print("F")
                
                // остани поток контекста - 1 поток
                DispatchQueue.main.sync { //стопани контекст - 1 поток последовательной
                    print("G")
                }
            }
            print("H")
        }
        print("I")
        
    }
    
    func testTask3() {
        
        print("A")
        
        DispatchQueue.main.async {
            print("B")
            
            DispatchQueue.main.async {
                print("С")
                
                DispatchQueue.main.async {
                    print("D")
                    
                    DispatchQueue.main.async {
                        print("E")
                    }
                }
            }
            
            DispatchQueue.global().sync { // 1 поток
                print(Thread.current)
                print("F")
                
                DispatchQueue.global().sync { // 1 поток - параллельная не блокируется
                    print(Thread.current)
                    print("G")
                }
            }
            print("H")
        }
        
        print("I")
    }
}
