//
//  SettingsVC.swift
//  Trivia App
//
//  Created by HaroldDavidson on 12/19/23.
//

import UIKit
import AVFoundation
import UserNotifications
import MessageUI
import StoreKit

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate {

    fileprivate var player: AVPlayer?
//    fileprivate let backButton = BackButton()
    
    var tableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var sectionCells = UIDevice.current.userInterfaceIdiom == .pad ?
                [
                    [SectionCells(title: "Background Music", cell: (.SettingsSwitchCell, 1)),
                     SectionCells(title: "Sound Effects", cell: (.SettingsSwitchCell, 2)),
                    ],
                    [SectionCells(title: "Check Out My Other Apps", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .checkOutOtherApps),
                     SectionCells(title: "Rate this App!", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .rating),
                     SectionCells(title: "Share", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .share)],
                    
                    [SectionCells(title: "Email Us", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .contact),
                     SectionCells(title: "Find us on Facebook", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .facebook)],
                    
                    [SectionCells(title: "Credits", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .credits),
                     SectionCells(title: "App Version: \(UIApplication.versionBuild())", cell: (.SettingsCell, 0), navigation: nil)],
                   
                   [SectionCells(title: "Leaderboards", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .leaderboards)]
                ]
    :
                [
                    [SectionCells(title: "Background Music", cell: (.SettingsSwitchCell, 1)),
                     SectionCells(title: "Sound Effects", cell: (.SettingsSwitchCell, 2)),
                     SectionCells(title: "Vibration", cell: (.SettingsSwitchCell, 3)),
                    ],
                    [SectionCells(title: "Check Out My Other Apps", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .checkOutOtherApps),
                     //SectionCells(title: "Rate this App!", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .rating),
                     SectionCells(title: "Share", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .share)],
                    
                    [SectionCells(title: "Email Us", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .contact),
                     SectionCells(title: "Find us on Facebook", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .facebook)],
                    
                    [SectionCells(title: "Credits", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .credits),
                     SectionCells(title: "App Version: \(UIApplication.versionBuild())", cell: (.SettingsCell, 0), navigation: nil)],
                    
                    [SectionCells(title: "Leaderboards", cell: (.SettingsCellNoSelectionStyle, 0), navigation: .leaderboards)]
                ]
    
    var sections = ["Settings", "Support Us", "Contact", "About", "Leaderboards"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func appMovedToBackground() {
        player?.pause()
    }
    
    @objc func appMovedToForeground() {
        player?.play()
    }
    
    fileprivate func setUpUI() {
//        playBackgroundVideo()
//        backButton.delegate = self
        configureTableView()
        
        let views = [
            //backButton,
            tableView]
        for view in views {
            self.view.addSubview(view)
        }
        NSLayoutConstraint.activate([
//            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            backButton.heightAnchor.constraint(equalToConstant: 50),
//            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
    }
    
    fileprivate func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsSwitchCell.self, forCellReuseIdentifier: "SettingsSwitchCell")
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = .clear
    }
    
//    // MARK: - Background Video
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
    
    // MARK: - Switch Logic
    func setSwitchPosition(tag: Int) -> Bool {
        switch tag {
        case 1:
            //return appConstants.backgroundMusicIsOn
            return true
        case 2:
            //return appConstants.soundEffectsIsOn
            return true
        case 3:
            return true
            //return appConstants.vibrationIsOn
            //        case 4:
            //            return appConstants.notificationsAreOn
            //        case 5:
            //            return appConstants.firtTimeAppRun
        default:
            return false
        }
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        //playClickSound()
        let tag = mySwitch.tag
//        if tag == 1 { // background music
//            appConstants.backgroundMusicIsOn ? UserDefaults.standard.set(false, forKey: "backgroundMusicIsOn") : UserDefaults.standard.set(true, forKey: "backgroundMusicIsOn")
//            if appConstants.backgroundMusicIsOn {
//                UserDefaults.standard.set(false, forKey: "backgroundMusicIsOn")
//                appConstants.backgroundMusicIsOn = false
//            } else {
//                UserDefaults.standard.set(true, forKey: "backgroundMusicIsOn")
//                appConstants.backgroundMusicIsOn = true
//            }
//            if appConstants.backgroundMusicIsOn {
//                let path = Bundle.main.path(forResource: AppConstants.backgroundMusic, ofType: nil)!
//                let url = URL(fileURLWithPath: path)
//                do {
//                    if appConstants.backgroundMusicIsOn {
//                        backgroundMusic = try AVAudioPlayer(contentsOf: url)
//                        backgroundMusic?.numberOfLoops = -1
//                        backgroundMusic?.play()
//                    } else {
//                        backgroundMusic?.pause()
//                    }
//                } catch {
//                    // couldn't load file :(
//                    print("failed")
//                }
//            } else {
//                backgroundMusic?.pause()
//            }
//        } else if tag == 2 { // sound effects
//            appConstants.soundEffectsIsOn.toggle()
//            UserDefaults.standard.set(appConstants.soundEffectsIsOn, forKey: "soundEffectsIsOn")
//        } else if tag == 3 { // vibration
//            appConstants.vibrationIsOn.toggle()
//            UserDefaults.standard.set(appConstants.vibrationIsOn, forKey: "vibrationIsOn")
//        }
    }
    
    // MARK: - Email
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["spelldevelopment@gmail.com"])
            //mail.setSubject(AppConstants.appName)
            
            let currentLocale = Locale.current
            let regionCode = currentLocale.regionCode
            let language = Locale.current.languageCode
            
            mail.setMessageBody("<div>Hello, Spell Development. I have a question, issue, or general inquiry.</div><br><div>I'm using an: \(UIDevice.current.model)</div><div>iOS Version: \(UIDevice.current.systemVersion)</div><div>App Version: \(UIApplication.versionBuild())</div>Region: \(regionCode ?? "N/A")<div>Language: \(language ?? "N/A")</div>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @objc func emailTapped() {
        sendEmail()
        vibrate()
    }
}

//extension SettingsVC: BackButtonDelegate {
//    func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
//    }
//}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionCells[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.sectionCells[indexPath.section][indexPath.row]

        switch item.cell.0 {
        case .SettingsSwitchCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSwitchCell")! as! SettingsSwitchCell
            cell.toggleSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
            cell.settingLabel.text = item.title
            cell.toggleSwitch.tag = item.cell.1
            //cell.settingLabel.textColor = AppConstants.labelColor
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.rgb(red: 28, green: 28, blue: 30, alpha: 1)
            cell.toggleSwitch.isOn = setSwitchPosition(tag: item.cell.1)
            return cell
        case .SettingsCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")! as! SettingsCell
            cell.settingLabel.text = item.title
            //cell.settingLabel.textColor = AppConstants.labelColor
            cell.backgroundColor = UIColor.rgb(red: 28, green: 28, blue: 30, alpha: 1)
            cell.arrowView.isHidden = true
            cell.selectionStyle = .none
            return cell
        case .SettingsCellNoSelectionStyle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")! as! SettingsCell
            cell.settingLabel.text = item.title
            //cell.settingLabel.textColor = AppConstants.labelColor
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.rgb(red: 28, green: 28, blue: 30, alpha: 1)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.text = sections[section]
        //lbl.textColor = AppConstants.labelColor
        view.backgroundColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sectionCells[indexPath.section][indexPath.row]
        switch item.navigation {
        case .checkOutOtherApps:
            vibrate()
            let vc = UIViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case .rating:
            vibrate()
            SKStoreReviewController.requestReviewInCurrentScene()
        case .contact:
            vibrate()
            sendEmail()
        case .facebook:
            vibrate()
//            if let url = URL(string: AppConstants.facebookURL) {
//                UIApplication.shared.open(url)
//            }
        case .share:
            vibrate()
//            let items = ["Check out this app! \n\n\(AppConstants.appStoreLink)"]
//            let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
//            present(ac, animated: true)
        case .credits:
            vibrate()
//            let vc = CreditsVC()
//            self.navigationController?.pushViewController(vc, animated: true)
        case .leaderboards:
            vibrate()
//            let vc = LeaderboardsVC()
//            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Do nothing - not a navigation cell")
        }
    }
}

struct SectionCells {
    let title: String
    let cell: (SettingsCellType, Int)
    var navigation: NavigationVC? = nil
}

enum SettingsCellType {
    case SettingsSwitchCell
    case SettingsCell
    case SettingsCellNoSelectionStyle
}

enum NavigationVC {
    case checkOutOtherApps
    case leaderboards
    case rating
    case contact
    case facebook
    case share
    case credits
}
