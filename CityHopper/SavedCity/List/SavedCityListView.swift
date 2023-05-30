//
//  SegmentListView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//


import Foundation
import UIKit

class SavedCityListView: UIView {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SavedCityTableViewCell.self, forCellReuseIdentifier: SavedCityTableViewCell.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(backgroundImageView)
        addSubview(tableView)
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
    }
}



