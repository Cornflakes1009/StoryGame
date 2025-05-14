//
//  OtherAppsCell.swift
//  Trivia App
//
//  Created by HaroldDavidson on 5/20/24.
//

import UIKit

class OtherAppsCell: UITableViewCell {
    
    //var appImageView = UIView()
    var appImage = UIImageView()
    //var cellButton = UIButton(type: .system)
    var appLabel = UILabel()
    
    // MARK: - Initializing the Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        configureTitleLabel()
        configureImageView()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(image: String) {
        appImage.image = UIImage(named: image)
    }
    
    // MARK: - Setting Up Views
    
    fileprivate func configureImageView() {
        appImage.contentMode = .scaleAspectFill
        contentView.addSubview(appImage)
        appImage.translatesAutoresizingMaskIntoConstraints = false
        appImage.layer.cornerRadius = 25
        appImage.layer.masksToBounds = true
        appImage.clipsToBounds = true

        
        appImage.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 5).isActive = true
        appImage.heightAnchor.constraint(equalToConstant: self.frame.width * 2/3).isActive = true
        appImage.widthAnchor.constraint(equalToConstant: self.frame.width * 2/3).isActive = true
        appImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        appImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    fileprivate func configureTitleLabel() {
        contentView.addSubview(appLabel)
        //appLabel.textColor = AppConstants.labelColor
        appLabel.lineBreakMode = .byWordWrapping
        appLabel.numberOfLines = 0
        appLabel.textAlignment = .center
        //appLabel.font = AppConstants.instructionLabelFont
        appLabel.layer.shadowRadius = 3.0
        appLabel.layer.shadowOpacity = 1.0
        appLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        appLabel.layer.masksToBounds = false

        appLabel.translatesAutoresizingMaskIntoConstraints = false

        appLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        appLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        appLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
}



