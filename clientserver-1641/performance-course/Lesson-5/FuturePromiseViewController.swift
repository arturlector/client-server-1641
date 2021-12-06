////
////  FuturePromiseViewController.swift
////  clientserver-1641
////
////  Created by Artur Igberdin on 06.12.2021.
////
//
//import UIKit
//
//struct Weather { }
//
//// MARK: - Future/Promise
//class Future<T> {
//   // Будущее значение имеет три состояния:
//   //      - опциональный nil, когда результат еще неизвестен;
//   //      - .success(T), успешно полученный результат;
//   //      - .failure(Error), ошибка.
//   fileprivate var result: Result<T, Error>? {
//       // Когда значение будет получено, мы должны вызвать все накопленные callback
//       didSet {
//           guard let result = result else { return }
//           callbacks.forEach { $0(result) }
//       }
//   }
//   private var callbacks = [(Result<T, Error>) -> Void]()
//
//   func add(callback: @escaping (Result<T, Error>) -> Void) {
//       callbacks.append(callback)
//
//       // Если результат уже доступен — вызываем callback сразу
//       result.map(callback)
//   }
//}
//
//class Promise<T>: Future<T> {
//   init(value: T? = nil) {
//       super.init()
//
//       // Если результат уже доступен, то мы сразу можем положить его
//       // в success case нашего Future
//       result = value.map(Result.success)
//   }
//
//   // Функции для выполнения или нарушения обещания
//   func fulfill(with value: T) {
//       result = .success(value)
//   }
//
//   func reject(with error: Error) {
//       result = .failure(error)
//   }
//}
//
//extension Future {
//   func map<NewType>(with closure: @escaping (T) throws -> NewType) -> Future<NewType> {
//       let promise = Promise<NewType>()
//       // Добавляем callback к существующему Future
//       add(callback: { result in
//           switch result {
//           case .success(let value):
//               do {
//                   // Когда значение готово, применяем к нему
//                   // модифицирующее замыкание и выполняем обещание
//                   let mappedValue = try closure(value)
//                   promise.fulfill(with: mappedValue)
//               } catch {
//                   promise.reject(with: error)
//               }
//           case .failure(let error):
//               promise.reject(with: error)
//           }
//       })
//       return promise
//   }
//}
//
//extension Future {
//   func flatMap<NewType>(with closure: @escaping (T) throws -> Future<NewType>) -> Future<NewType> {
//
//       let promise = Promise<NewType>()
//
//       // Добавляем callback к существующему Future
//       add(callback: { result in
//           switch result {
//           case .success(let value):
//               do {
//                   // Когда значение первого Promise получено,
//                   // на его основе генерируем новый Promise
//                   let chainedPromise = try closure(value)
//                   // и добавляем к нему новый callback
//                   chainedPromise.add(callback: { result in
//                       switch result {
//                       case .success(let value):
//                           promise.fulfill(with: value)
//                       case .failure(let error):
//                           promise.reject(with: error)
//                       }
//                   })
//               } catch {
//                   promise.reject(with: error)
//               }
//           case .failure(let error):
//               promise.reject(with: error)
//           }
//       })
//
//       return promise
//   }
//}
//
////MARK: - Operations
//
//func fetchWeatherData() -> Promise<Data> {
//      // Создаем исходный промис, который будет возвращать
//      // Future<Data>, содержащую информацию о прогнозах погоды
//      let promise = Promise<Data>()
//
//      let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&units=metric&appId=8b32f5f2dc7dbd5254ac73d984baf944")!
//
//      // Выполняем стандартный сетевой запрос
//      URLSession.shared.dataTask(with: url) { data, _, error in
//          // И в completion выполняем или нарушаем обещание
//          if let error = error {
//              promise.reject(with: error)
//          } else {
//              promise.fulfill(with: data ?? Data())
//          }
//      }.resume()
//
//      return promise
//  }
//
//class FuturePromiseViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
////        let promise = fetchWeatherData()
////        promise.add { result in
////
////            switch result {
////            case .success(let data):
////                print(data)
////            case .failure(let error):
////                print(error)
////            }
////        }
//
//        authorize(with: "test@test.com", password: "qwerty12345")
//            .flatMap { token -> Future<Data> in
//                self.fetchWeather(city: "Kazan", token: token)
//            }
//            .map { data -> [Weather] in
//                 self.parse(data)
//            }
//            .add { result in
//                switch result {
//                case .success(let weathers):
//                    print(weathers)
//                    //Вывести на UI
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
//
//
//    func authorize(with email: String, password: String) -> Promise<String> {
//        let promise = Promise<String>()
//        //Запрос и получение токена
//        DispatchQueue.global().async {
//            promise.fulfill(with: "12434112233122331123424223423423")
//        }
//        return promise
//    }
//
//    func fetchWeather(city: String, token: String) -> Promise<Data> {
//        let promise = Promise<Data>()
//        //Запрос и получение бинарника
//        promise.fulfill(with: Data())
//        return promise
//    }
//
//    func parse(_ data: Data) -> [Weather] {
//        //Парсинг и возврат моделей в массив
//        return [Weather(), Weather()]
//    }
//
//
//
//}
