//
//  ExampleHeaderView.swift
//  ExampleProject
//
//  Created by Carmen Cerino on 7/21/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import UIKit

class ExampleHeaderView: UITableViewHeaderFooterView {

    let primaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.green
        return label
    }()

    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.blue
        return label
    }()
    
    override init(reuseIdentifier: String?) {

        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(primaryLabel)
        self.contentView.addSubview(secondaryLabel)
        self.contentView.backgroundColor = UIColor.red

        let margins = contentView.layoutMarginsGuide
        
        primaryLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        primaryLabel.trailingAnchor.constraint(greaterThanOrEqualTo: secondaryLabel.leadingAnchor, constant: 8.0)
        secondaryLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        primaryLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        secondaryLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
