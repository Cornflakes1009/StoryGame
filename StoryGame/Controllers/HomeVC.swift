//
//  HomeVC.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/26/25.
//

import UIKit

class HomeVC: UIViewController {

    let titleLbl = UILabel()
    lazy var startBtn: UIButton = {
        let button = UIButton(type: .system)
        button.isEnabled = true
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
        return button
    }()
    
    let playLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's play!"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        playLabel.startBlink()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        // this is to handle dismissing any view controller back to this one
        playLabel.startBlink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playLabel.stopBlink()
    }
    
    @objc func willEnterForeground() {
        playLabel.stopBlink()
        playLabel.startBlink()
    }
    
    
    
    
    
    
    
    fileprivate func setUpViews() {
        view.backgroundColor = .black
        
        let views = [titleLbl, startBtn, playLabel]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
        
        titleLbl.font = UIFont(name: "PressStart2P-Regular", size: 30)
        titleLbl.text = "Woven Quest"
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        
        let startBtnImageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light, scale: .large)
        let startBtnImage = UIImage(systemName: "play.circle", withConfiguration: startBtnImageConfig)
        startBtn.addTarget(nil, action: #selector(startBtnTapped), for: .touchUpInside)
        startBtn.setImage(startBtnImage, for: .normal)
        
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            playLabel.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: 20),
            playLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
    }
    
    // Actions
    @objc func startBtnTapped() {
        let vc = GameVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
