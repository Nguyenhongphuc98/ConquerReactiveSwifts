//
//  UserService.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/5/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON

class UserService {
    
    let session = URLSession.shared
    
    private let URLString: String = "https://jsonplaceholder.typicode.com/users"
    
    //signalproducer co trach nhiem phat ra tin hieu (luong users) khi load complete
    func fetchUsers() -> SignalProducer<[User], Error> {
        
        return SignalProducer { observer, disposable in
            if let URLUsers = URL(string: self.URLString) {
                        
                let task = self.session.dataTask(with: URLUsers) { (data, response, error) in
                    if error != nil {
                        observer.send(error: error!)
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("status not OK")
                        return
                    }
                    
                    guard let mineType = response?.mimeType, mineType == "application/json" else {
                        print("wrong mine type")
                        return
                    }
                    
                    //xu ly data neu khong bi loi va dung format
                    do {
                        let json = try JSON(data: data!)
                        let users: [User] = json.arrayValue.compactMap { (u) -> User in
                            return User(id: u["id"].stringValue,
                                        name: u["name"].stringValue,
                                        username: u["username"].stringValue,
                                        email: u["email"].stringValue,
                                        phone: u["phone"].stringValue, website: u["website"].stringValue)
                        }
                        
                        observer.send(value: users)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                }
                
                task.resume()
            } else {
                //tao sample data neu URL loi
                var users: [User] = [User]()
                for i in 0..<10 {
                    let user = User.init(id: String(i), name: "hong phuc " + String(i), username: "phuc1998", email: "hello@gmail.com", phone: "012345678", website: "www.abc.com")
                    users.append(user)
                }
                
                //thong bao da load xong danh sach users
                observer.send(value: users)
            }
        }
    }
}
