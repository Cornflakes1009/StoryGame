//
//  ViewController.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/22/25.
//

import UIKit

class GameViewController: UIViewController {

    let storyLabel = UILabel()
    let optionsStack = UIStackView()

    var currentSceneID = "start"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showScene(id: currentSceneID)
    }

    func setupUI() {
        storyLabel.numberOfLines = 0
        storyLabel.textColor = .white
        //storyLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .regular)
        storyLabel.font = UIFont(name: "PressStart2P-Regular", size: 14)

        storyLabel.translatesAutoresizingMaskIntoConstraints = false

        optionsStack.axis = .vertical
        optionsStack.spacing = 12
        optionsStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(storyLabel)
        view.addSubview(optionsStack)

        NSLayoutConstraint.activate([
            storyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            optionsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func showScene(id: String) {
        guard let scene = scenes[id] else { return }

        currentSceneID = id

        optionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for option in scene.options {
            let button = UIButton(type: .system)
            button.setTitle(option.title, for: .normal)
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .medium)
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            button.addAction(UIAction { [weak self] _ in
                self?.showScene(id: option.nextSceneID)
            }, for: .touchUpInside)

            optionsStack.addArrangedSubview(button)
        }
        
        typeTextOnLabel(label: storyLabel, text: scene.text)
    }
    
    func typeTextOnLabel(label: UILabel, text: String) {
        label.text = ""
        for char in text {
            var delayTime = 0.03
            
            if char == " " {
                delayTime = 0.12
            } else if char == "." || char == "," || char == "!" || char == "?" {
                delayTime = 0.35
            }
            
            if char == "$" {
                delayTime = 0.35
            } else {
                label.text! += "\(char)"
            }
            
            RunLoop.current.run(until: Date()+delayTime)
        }
    }
}


