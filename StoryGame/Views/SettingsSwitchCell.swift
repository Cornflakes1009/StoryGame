//
//  SettingsSwitchCell.swift
//  Trivia App
//
//  Created by HaroldDavidson on 5/9/24.
//

import UIKit

class SettingsSwitchCell: UITableViewCell {
    
    var categoryImageView = UIView()
    var categoryImage = UIImageView()
    var cellButton = UIButton(type: .system)
    var cellView = UIView()
    var settingLabel = UILabel()
    let toggleSwitch = UISwitch()
    
    // MARK: - Initializing the Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Up Views
    fileprivate func configureCellView() {
        addSubview(cellView)
        contentView.addSubview(toggleSwitch)
        contentView.addSubview(settingLabel)

        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        toggleSwitch.setOn(false, animated: true)
        //toggleSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControl.Event.valueChanged)
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            toggleSwitch.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
            toggleSwitch.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            
            settingLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            settingLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
        ])
    }
    
//    @objc func switchChanged(sender: UISwitch!) {
//        print("Switch value is \(sender.isOn)")
//    }
}


