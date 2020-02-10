//
//  TrackVC.swift
//  ConquerReactiveSwift
//
//  Created by CPU11716 on 2/10/20.
//  Copyright © 2020 CPU11716. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class RepoVC: UIViewController {
    @IBOutlet weak var repoSearchBar: UISearchBar!
    @IBOutlet weak var repoTableview: RepoTableView!
    
    var progess: UIView!
    
    var viewModel: RepoViewModel = RepoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        repoSearchBar.text = ""
        progess = setUpProgessbar(title: "Loading...")
        view.addSubview(progess)
        
        viewModel.repos
            .signal
            .observe(on: UIScheduler())
            .observe(Signal<[RepoProtocol], Never>.Observer(value: { repos in
                self.repoTableview.reloadData(r: repos)
                print("reload")
            }, failed: { (never) in
                print(never)
            }, completed: {
                print("complete")
            }))
        
        viewModel.isLoading
            .signal
            .observe(Signal<Bool, Never>.Observer(value: { (loading) in
                if loading {
                    self.progess.isHidden = false
                    print("loading....")
                } else {
                    self.progess.isHidden = true
                    print("loaded")
                }
            }))
        
        let searchSignal = repoSearchBar.reactive.continuousTextValues.compactMap({$0})
        viewModel.fetchRepos(textSignal: searchSignal)
    }
    
    func setUpProgessbar(title: String) -> UIView{
        let boxView = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25, width: 180, height: 50))
        boxView.backgroundColor = UIColor.gray
        boxView.alpha = 0.8
        boxView.layer.cornerRadius = 10

        //Here the spinnier is initialized
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.startAnimating()

        let textLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        textLabel.textColor = UIColor.white
        textLabel.text = title

        boxView.addSubview(activityView)
        boxView.addSubview(textLabel)
        boxView.isHidden = true

        return boxView
    }
}
