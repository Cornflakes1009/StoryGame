//
//  SettingsCell.swift
//  Trivia App
//
//  Created by HaroldDavidson on 5/12/24.
//
import UIKit

class SettingsCell: UITableViewCell {
    
    var cellView = UIView()
    var settingLabel = UILabel()
    let arrowView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    
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
        contentView.addSubview(settingLabel)
        contentView.addSubview(arrowView)

        arrowView.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        //arrowView.tintColor = AppConstants.labelColor
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            settingLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            settingLabel.trailingAnchor.constraint(equalTo: arrowView.leadingAnchor, constant: -20),
            
            arrowView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            arrowView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
        ])
    }
}
