//
//  ViewController.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/4/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logginButton: UIButton!
    
    let validColor: UIColor = UIColor.init(red: 212/255, green: 237/255, blue: 218/255, alpha: 1.0)
    let inValidColor: UIColor = UIColor.init(red: 255/255, green: 243/255, blue: 205/255, alpha: 1.0)
    let activeColor: UIColor = UIColor.init(red: 52/255, green: 174/255, blue: 235/255, alpha: 1.0)
    let deActiveColor: UIColor = UIColor.init(red: 226/255, green: 227/255, blue: 229/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //test in consonle
        //tao 1 observer de lang nghe va lam gi do khi co tin hieu phat ra
//        let observer = Signal<Bool,Error>.Observer(value: {
//            value in print("receive value: \(value)")
//        })
//        let observer2 = Signal<Bool,Error>.Observer(value: {
//            value in print("hehe")
//        })
//
//        //tao 1 signal la nguon phat ra tin hieu
//        let (output, input) = Signal<Int, Error>.pipe()
//
//        //gui value den signal
//        for i in 0...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 * Double(i)) {
//                input.send(value: i)
//            }
//        }
//
//        //lang nghe va hanh dong bang observer da tao
//        //output.observe(observer)
//        let boolSignal = output.map { (intValue) -> Bool in
//            return intValue > 4
//        }
//        boolSignal.observe(observer)
//        let disposeable = boolSignal.observe(observer2)
//        disposeable?.dispose()
        
//        //su dung signalProducer
//        //tao 1 observer
//        let observer = Signal<String, Error>.Observer({event in
//            switch event {
//            case let .value(v):
//                print(v)
//            case .completed:
//                print("complete")
//            default:
//                break
//            }
//            
//        })
//
//        //tao signalProducer
//        let signalProducer: SignalProducer<String, Error> = SignalProducer {(observer, lifetime) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                observer.send(value: "hello")
//                observer.sendCompleted()
//            }
//        }
//
//        signalProducer.start(observer)
//        
        //interaction with UI
//        let signal = usernameTextField.rac_textSignal()
//        let observer = Signal<Bool, Never>.Observer(value: { (textInput) in
//            print("change: \(textInput)")
//        }, failed: { (error) in
//            print("error: \(error)")
//        }, completed: {
//            print("complete")
//        }) {
//            print("interup")
//        }

        setUpUI()
        
        //assign signal for UI, any change in UI will emit a event to observer
        let usernameSignal = usernameTextField.reactive.continuousTextValues
            .map { (input) -> Bool in
                return self.isValidUsername(username: input)
            }
        
        usernameSignal.observe(Signal<Bool, Never>.Observer { (isValid) in
            self.usernameTextField.layer.borderColor = isValid.value! ? self.validColor.cgColor : self.inValidColor.cgColor
        })
        
        let passwordSignal = passwordTextField.reactive.continuousTextValues
            .map { (password) -> Bool in
                return self.isValidPassword(password: password)
        }
        
        passwordSignal.observe(Signal<Bool, Never>.Observer { (isValid) in
            self.passwordTextField.layer.borderColor = isValid.value! ? self.validColor.cgColor : self.inValidColor.cgColor
        })
        
        //combine signal and react to login button
        let activeLoginSignal = Signal.combineLatest(usernameSignal, passwordSignal)
            .map { (username, password) -> Bool in
                return username && password
        }
        
        activeLoginSignal.observe(Signal<Bool, Never>.Observer { (active) in
            self.logginButton.isEnabled = active.value!
        })
    }
    
    func setUpUI() -> () {
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.cornerRadius = 5.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 5.0
        logginButton.isEnabled = false
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setFillColor(activeColor.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let activeImage = UIGraphicsGetImageFromCurrentImageContext()
            
            context.setFillColor(deActiveColor.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let deActiveImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            logginButton.setBackgroundImage(activeImage, for:UIControl.State.normal)
            logginButton.setBackgroundImage(deActiveImage, for:UIControl.State.disabled)
        }
    }

    func isValidUsername(username: String) -> Bool {
        return username.hasSuffix("@gmail.com")
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6
    }
}

