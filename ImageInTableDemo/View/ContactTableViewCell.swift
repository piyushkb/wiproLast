//
//  ContactTableViewCell.swift
//  contactsapp
//
//  Created by SoftAuthor on 2019-04-20.
//  Copyright © 2019 SoftAuthor. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var userInfo:Rows? {
        didSet {
            guard let contactItem = userInfo else {return}
            if let name = contactItem.title {
                profileImageView.image = UIImage(named: name)
                nameLabel.text = name
            }
            if let desTitle = contactItem.description {
                detailedLabel.text = "\(desTitle) "
            }
            
          
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        
        view.autoresizesSubviews = true
        return view
    }()
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(detailedLabel)
        self.contentView.addSubview(containerView)
       
        
        //profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10).isActive = true
       // profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:150).isActive = true
       // profileImageView.bottomAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        
        //containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10).isActive = true
        containerView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor,constant: 10).isActive = true
        
        
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
            
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor ).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        
        
        NSLayoutConstraint.activate([

            detailedLabel.topAnchor.constraint(equalTo: self.nameLabel.layoutMarginsGuide.bottomAnchor, constant:10),
            detailedLabel.trailingAnchor.constraint(equalTo: self.nameLabel.layoutMarginsGuide.trailingAnchor),
            detailedLabel.leadingAnchor.constraint(equalTo: self.nameLabel.layoutMarginsGuide.leadingAnchor)
        ])
       //jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
//               jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//               jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
//               jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    func setupDataFromModel(model: Rows) {
        if let imageUrl = model.imageHref{
           self.nameLabel.text = model.title ?? "No Title"
       self.profileImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "loader"))
            self.detailedLabel.text = model.description ?? "No description"
       }
    }
}
