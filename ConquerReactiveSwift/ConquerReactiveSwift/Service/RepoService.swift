//
//  RepoService.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift
import SwiftyJSON

class RepoService {
    
    let session = URLSession.shared
    let urlString: String = "https://api.github.com/search/repositories"
    
    func fetchRepos(state: Signal<String, Never>) -> Action<String, [Repository], Error> {
        let textProperty = Property(initial: "", then: state)
        return Action<String, [Repository], Error>(
            state: textProperty,
            execute: fetchSignalProducer)
    }
    
    func fetchSignalProducer(text: String, input: String) -> SignalProducer<[Repository], Error> {
        
        return SignalProducer { observer, disposable in
            if var urlComponents = URLComponents(string: self.urlString) {
                
                urlComponents.query = "q=\(text)"
                
                guard let url = urlComponents.url else {
                    print("can't init url in repo service")
                    return
                }
                
                let task = self.session.dataTask(with: url) { (data, response, error) in
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
                        let repos: [Repository] = json.dictionaryValue["items"]!.arrayValue.compactMap { (r) -> Repository in
                            return Repository(
                                        name: r["name"].stringValue,
                                        des: r["description"].stringValue,
                                        lang: r["language"].stringValue)
                        }
                        
                        observer.send(value: repos)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                }
                
                task.resume()
            } 
        }
    }
}
