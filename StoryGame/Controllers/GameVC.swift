//
//  GameVC.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/22/25.
//

import UIKit
import AVFoundation

class GameVC: UIViewController {

    var player = AVAudioPlayer()
    
    fileprivate let backButton = BackButton()
    fileprivate let helpButton = HelpButton()
    let storyLabel = UILabel()
    let optionsStack = UIStackView()

    var currentSceneID = "start"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showScene(id: currentSceneID)
        
    }

    func setupUI() {
        backButton.delegate = self
        helpButton.delegate = self
        storyLabel.numberOfLines = 0
        storyLabel.textColor = .white
        storyLabel.font = UIFont(name: "PressStart2P-Regular", size: 14)

        storyLabel.translatesAutoresizingMaskIntoConstraints = false

        optionsStack.axis = .vertical
        optionsStack.spacing = 12
        optionsStack.translatesAutoresizingMaskIntoConstraints = false
        optionsStack.alpha = 0

        view.addSubview(backButton)
        view.addSubview(helpButton)
        view.addSubview(storyLabel)
        view.addSubview(optionsStack)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            helpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            helpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            helpButton.heightAnchor.constraint(equalToConstant: 50),
            helpButton.widthAnchor.constraint(equalToConstant: 50),
            
            storyLabel.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: 20),
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
        optionsStack.alpha = 0
        typeTextOnLabel(label: storyLabel, text: scene.text, completion: {
            self.showOptions(scene: scene)
        })
    }
    
    func showOptions(scene: GameScene) {
        optionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for option in scene.options {
            let button = UIButton(type: .system)
            button.setTitle(option.title, for: .normal)
            
            button.titleLabel?.numberOfLines = 0
            button.titleLabel?.lineBreakMode = .byWordWrapping
            button.titleLabel?.textAlignment = .center // optional, center-align the text nicely

            button.titleLabel?.adjustsFontSizeToFitWidth = false
            button.titleLabel?.minimumScaleFactor = 1.0

            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .medium)
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true // minimum height for button
            button.titleLabel?.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10).isActive = true
            button.titleLabel?.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10).isActive = true
            button.titleLabel?.topAnchor.constraint(equalTo: button.topAnchor, constant: 10).isActive = true
            button.titleLabel?.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10).isActive = true

            button.addAction(UIAction { [weak self] _ in
                self?.showScene(id: option.nextSceneID)
                // audio
                do {
                    self?.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "story_option_tapped", ofType: "mp3")!))
                    self?.player.play()
                } catch {
                    print("Issue playing play_tapped.mp3")
                }
            }, for: .touchUpInside)

            optionsStack.addArrangedSubview(button)
           
            UIView.animate(withDuration: 0.5) {
                self.optionsStack.alpha = 1
            }
        }
    }
    
    func typeTextOnLabel(label: UILabel, text: String, completion: @escaping () -> Void) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12

        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: label.font ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: label.textColor ?? .white,
            .paragraphStyle: paragraphStyle
        ]

        let attributedString = NSMutableAttributedString()

        DispatchQueue.global(qos: .userInitiated).async {
            for (index, char) in text.enumerated() {
                var delayTime = 0.03

                if char == " " {
                    delayTime = 0.12
                } else if [".", ",", "!", "?", "$"].contains(char) {
                    delayTime = 0.35
                }

                DispatchQueue.main.async {
                    let charString = NSAttributedString(string: String(char), attributes: baseAttributes)
                    attributedString.append(charString)
                    label.attributedText = attributedString
                }

                Thread.sleep(forTimeInterval: delayTime)

                if index == text.count - 1 {
                    // Last character, call completion on main thread
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
//    func typeTextOnLabel(label: UILabel, text: String) {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 12
//
//        let baseAttributes: [NSAttributedString.Key: Any] = [
//            .font: label.font ?? UIFont.systemFont(ofSize: 14),
//            .foregroundColor: label.textColor ?? .white,
//            .paragraphStyle: paragraphStyle
//        ]
//
//        let attributedString = NSMutableAttributedString()
//
//        for char in text {
//            var delayTime = 0.03
//
//            if char == " " {
//                delayTime = 0.12
//            } else if [".", ",", "!", "?", "$"].contains(char) {
//                delayTime = 0.35
//            }
//
//            let charString = NSAttributedString(string: String(char), attributes: baseAttributes)
//            attributedString.append(charString)
//            label.attributedText = attributedString
//
//            RunLoop.current.run(until: Date() + delayTime)
//        }
//    }
}

extension GameVC: BackButtonDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GameVC: HelpButtonDelegate {
    func helpButtonTapped() {
        let vc = SettingsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
