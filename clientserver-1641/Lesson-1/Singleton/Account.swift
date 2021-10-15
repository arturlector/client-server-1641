//
//  Account.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 15.10.2021.
//

import Foundation

final class Account {
    
    private init() {}
    
    //let - переменную инициализировали и не можем больше менять (константа)
    //static - храниться в статической памяти, неубиваемый объект который всегда висит в памяти
    static let shared = Account()
    
    var name: String = ""
    var cash: Int = 0
}
