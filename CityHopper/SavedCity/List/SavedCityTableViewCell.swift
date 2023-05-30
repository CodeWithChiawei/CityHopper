//
//  ListViewTableViewCell.swift
//  CityHopper
//
//  Created by chiawei wen on 4/7/23.
//

import Foundation
import UIKit

class SavedCityTableViewCell: UITableViewCell {
    
    static let identifier = {
        return String(describing: SavedCityTableViewCell.self)
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
     private let flagImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
   private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .clear
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let countryCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var isFavoritedImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.layer.cornerRadius = 50
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(containerView)
        containerView.addSubview(flagImageView)
        containerView.addSubview(isFavoritedImage)
        containerView.addSubview(cityLabel)

        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        
        flagImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        flagImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        
        isFavoritedImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        isFavoritedImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        isFavoritedImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        isFavoritedImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        cityLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        cityLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: isFavoritedImage.leadingAnchor).isActive = true
    }
    
    func configCell(imageData: Data, cityName: String, isCityFavorited: Bool) {
        flagImageView.image = UIImage(data: imageData)
        cityLabel.text = cityName
        
        if isCityFavorited {
            isFavoritedImage.image = UIImage(systemName: "heart.fill")?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
        } else {
            isFavoritedImage.image = nil
        }
    }
}
