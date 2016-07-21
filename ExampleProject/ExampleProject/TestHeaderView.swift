//
//  TestHeaderView.swift
//  ExampleProject
//
//  Created by Carmen Cerino on 7/21/16.
//  Copyright © 2016 Duncan Lewis. All rights reserved.
//

import UIKit

class TestHeaderView: UITableViewHeaderFooterView {

    let primaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.greenColor()
        return label
    }()

    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.blueColor()
        return label
    }()
    
    override init(reuseIdentifier: String?) {

        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(primaryLabel)
        self.contentView.addSubview(secondaryLabel)
        self.contentView.backgroundColor = UIColor.redColor()

        let margins = contentView.layoutMarginsGuide
        
        primaryLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        primaryLabel.trailingAnchor.constraintGreaterThanOrEqualToAnchor(secondaryLabel.leadingAnchor, constant: 8.0)
        secondaryLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        primaryLabel.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
        secondaryLabel.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
