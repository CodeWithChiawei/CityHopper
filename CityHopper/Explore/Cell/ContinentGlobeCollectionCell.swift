//
//  File.swift
//  TripCity
//
//  Created by chiawei wen on 3/9/23.
//

import Foundation
import UIKit

class ContinentGlobeCollectionCell: UICollectionViewCell {
    
    static let identifier = {
        return String(describing: ContinentGlobeCollectionCell.self)
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.isUserInteractionEnabled = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.image = UIImage(named: "asia")
        imageView.layer.cornerRadius = 10
        imageView.sizeToFit()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUIConstraints()
        self.addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.label.text = ""
        self.backgroundColor = UIColor.clear
    }
    
    private func setUIConstraints() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func cellConfigures(backgroundColor: UIColor, continentImage: UIImage, continentName: String, isSelected: Bool) {
        if !isSelected {
            self.backgroundColor = backgroundColor
        } else if isSelected {
            self.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.9)
        }
        self.imageView.image = continentImage
        self.label.text = continentName
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
    }
    
    func setTapGesture(with labelTapGesture: UITapGestureRecognizer, imageTapGesture: UITapGestureRecognizer, and indexPath: IndexPath) {
        self.label.addGestureRecognizer(labelTapGesture)
        self.imageView.addGestureRecognizer(imageTapGesture)
        labelTapGesture.view?.tag = indexPath.row
        imageTapGesture.view?.tag = indexPath.row
    }
}

extension UICollectionViewCell {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
}
