//
//  ViewController.swift
//  fdcNews
//
//  Created by Denis Fedorets on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NetworkManager.shared.getNews { (news) in
            guard let news = news else {
                return
            }
            print(news[0].title)
            
        }
        
    }


}

