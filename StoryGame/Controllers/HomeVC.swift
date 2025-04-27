//
//  HomeVC.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/26/25.
//

import UIKit

class HomeVC: UIViewController {

    let titleLbl = UILabel()
    let startBtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
    }
    
    fileprivate func setUpViews() {
        view.backgroundColor = .black
        
        let views = [titleLbl, startBtn]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        titleLbl.font = UIFont(name: "PressStart2P-Regular", size: 30)
        titleLbl.text = "Woven Quest"
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        
        startBtn.setTitle("Start", for: .normal)
        startBtn.addTarget(nil, action: #selector(startBtnTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // Actions
    @objc func startBtnTapped() {
        let vc = GameVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
