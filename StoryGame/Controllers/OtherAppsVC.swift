//
//  OtherAppsVC.swift
//  StoryGame
//
//  Created by Harold Davidson on 5/12/25.
//

import UIKit
import AVFoundation
//import GoogleMobileAds

class OtherAppsVC: UIViewController {
    
    let otherApps = [OtherApps(name: "Iron Throne Trivia", url: "https://apps.apple.com/us/app/iron-throne-trivia/id1543810844", image: "Iron Throne Trivia"), OtherApps(name: "Weeb", url: "https://apps.apple.com/us/app/weeb/id1570239237", image: "Weeb")]
    fileprivate var player: AVPlayer?
    fileprivate let backButton = BackButton()
    
    fileprivate let otherAppsTable = UITableView()
    
    fileprivate let backgroundImageView = {
        let imageView = UIImageView()
        //imageView.image = AppConstants.backgroundImage
        return imageView
    }()
    
//    fileprivate let bannerView: GADBannerView = {
//        let bannerView = GADBannerView()
//        return bannerView
//    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        //setupBannerView()
        
        // handling the app moving to the background and foreground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    @objc func appMovedToBackground() {
        //player?.pause()
    }
    
    @objc func appMovedToForeground() {
        player?.play()
    }
    
    // MARK: - Building UI
    fileprivate func setUpUI() {
        backButton.delegate = self
        otherAppsTable.delegate = self
        otherAppsTable.dataSource = self
        otherAppsTable.register(OtherAppsCell.self, forCellReuseIdentifier: "OtherAppsCell")
        otherAppsTable.rowHeight = UITableView.automaticDimension
        otherAppsTable.estimatedRowHeight = 350
        otherAppsTable.backgroundColor = .clear
        otherAppsTable.separatorStyle = .none
        
        //view.backgroundColor = AppConstants.backgroundColor
        //playBackgroundVideo()
        
        let views: [UIView] = [backButton, otherAppsTable]
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        })
        
//        if AppConstants.backgroundImage != UIImage(named: "") {
//            view.addSubview(backgroundImageView)
//            NSLayoutConstraint.activate([
//                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            ])
//        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            otherAppsTable.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            otherAppsTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            otherAppsTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            otherAppsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            otherAppsTable.bottomAnchor.constraint(equalTo: bannerView.topAnchor, constant: -20),
            
//            bannerView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            bannerView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            bannerView.heightAnchor.constraint(equalToConstant: 50),
//            bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - AdMob
//    fileprivate func setupBannerView() {
//        // starting ads on the bannerview
//        bannerView.adUnitID = AppConstants.transitionScreenBannerAdId
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//    }

    // MARK: - Background Video
//    func playBackgroundVideo() {
//        if AppConstants.backgroundVideo != "" {
//            let filePath = Bundle.main.path(forResource: AppConstants.backgroundVideo, ofType: ".mp4")
//            if let path = filePath {
//                player = AVPlayer(url: URL(fileURLWithPath: path))
//                player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
//                let playerLayer = AVPlayerLayer(player: player)
//                playerLayer.frame = self.view.frame
//                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//                self.view.layer.insertSublayer(playerLayer, at: 0)
//                NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
//                player!.seek(to: CMTime.zero)
//                player!.play()
//                player?.isMuted = true
//            }
//        }
//    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
}

extension OtherAppsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherAppsCell")! as! OtherAppsCell
        cell.selectionStyle = .none
        cell.appLabel.text = otherApps[indexPath.row].name
        cell.appImage.image = UIImage(named: otherApps[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vibrate()
        if let url = URL(string: otherApps[indexPath.row].url) {
            UIApplication.shared.open(url)
        }
    }
}

extension OtherAppsVC: BackButtonDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}


struct OtherApps {
    let name: String
    let url: String
    let image: String
}
