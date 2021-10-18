//
//  NetworkingViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import UIKit
import Alamofire

class NetworkingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sendGetRequest() //GET запрос через URLSession
        
        //sendGetRequestURLComponents() //GET запрос через URLSession, URLComponents - добавляет кодировку
        
        //sendPostRequestURLComponents() //POST запрос
        
        sendGetRequestAlamofire()
    }
    
    func sendGetRequestAlamofire() {
        
        let params: Parameters = [
            "q": "Moscow,DE&",
            "appid": "b1b15e88fa797225412429c1c50c122a1"
        ]
        
        guard let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?") else { return }
        
        AF.request(url, parameters: params).responseJSON { response in
            
            print(response.value)
        }
    }
    
    
    func sendPostRequestURLComponents() {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для url
        var urlComps = URLComponents()
        // устанавливаем схему
        urlComps.scheme = "http"
        // устанавливаем хост
        urlComps.host = "jsonplaceholder.typicode.com"
        // путь
        urlComps.path = "/posts"
        // параметры для запроса
        urlComps.queryItems = [
            URLQueryItem(name: "title", value: "foo"),
            URLQueryItem(name: "body", value: "bar"),
            URLQueryItem(name: "userId", value: "1")
        ]
        
        guard let url = urlComps.url else { return }
        
        // создаем запрос
        var request = URLRequest(url: url)
        // указываем метод
        request.httpMethod = "PATCH"
        
        
        // задача для запуска
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            // выводим в консоль
            print(json)
        }
        // запускаем задачу
        task.resume()
    }
    
    
    func sendGetRequestURLComponents() {
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlComps = URLComponents()
        // устанавливаем схему
        urlComps.scheme = "http"
        // устанавливаем хост
        urlComps.host = "samples.openweathermap.org"
        // путь
        urlComps.path = "/data/2.5/forecast"
        // параметры для запроса
        urlComps.queryItems = [
            URLQueryItem(name: "q", value: "München,DE"),
            URLQueryItem(name: "appid", value: "b1b15e88fa797225412429c1c50c122a1")
        ]
        
        guard let url = urlComps.url else { return }
        
        // задача для запуска
        let task = session.dataTask(with: url) { (data, response, error) in
            
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            // выводим в консоль
            print(json)
        }
        // запускаем задачу
        task.resume()
    }
    
    func sendGetRequest() {
        
        guard let url = URL(string: "http://samples.openweathermap.org/data/2.5/forecast?q=Moscow,DE&appid=b1b15e88fa797225412429c1c50c122a1") else { return }
        
        let session = URLSession.shared
        
        //GET-запрос
        let task = session.dataTask(with: url) { data, response, error in
            
            //Сериализация в JSON
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print(json as Any)
        }
        task.resume()
    }
    
    
    
}
