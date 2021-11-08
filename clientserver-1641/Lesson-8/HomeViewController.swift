//
//  HomeViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 08.11.2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let authService = Auth.auth()
    
    let ref = Database.database().reference(withPath: "cities") //ссылка на контейнер в Firebase Database

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signOutAction(_ sender: Any) {
        
        try? authService.signOut()
        showLoginVC()
    }
    
    @IBAction func addCityAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Добавить город", message: nil, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        let save = UIAlertAction(title: "Сохранить город", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                  let cityName = textField.text else { return }
            
            //готовим модель
            let city = CityFirebase(name: cityName, zipcode: Int.random(in: 10000...999999))
            
            //готовим контейнер для сохранения
            let cityContainerRef = self.ref.child(cityName)
            
            //Сохранение в контейнер город
            cityContainerRef.setValue(city.toAnyObject())
        }
        
        alert.addTextField()
        alert.addAction(cancel)
        alert.addAction(save)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    private func showLoginVC() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    

}
