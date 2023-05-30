//
//  CityProfileContainerView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/12/23.
//

import Foundation
import UIKit

class ProfileContainerView: UIView {
    
    private let flagImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.backgroundColor = .blue
           imageView.layer.borderColor = UIColor.black.cgColor
           imageView.layer.borderWidth = 0.5
           imageView.layer.cornerRadius = 60
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()
       
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        return label
    }()
   
    private let flagImageBorderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 65
        return label
    }()
    
    let favoritedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "heart",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 33
        button.addShadow()
        return button
    }()
    
    
    private let willVisitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.text = "   Future Travel"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private let line1: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    private let didVisitedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.text = "   Visited"
        return label
    }()
    
    private let line2: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    
    let willVisitSwitch: UISwitch = {
        let UIswitch = UISwitch()
        UIswitch.translatesAutoresizingMaskIntoConstraints = false
        UIswitch.backgroundColor = .clear
        return UIswitch
    }()
    
    let didVisitedSwitch: UISwitch = {
        let UIswitch = UISwitch()
        UIswitch.translatesAutoresizingMaskIntoConstraints = false
        UIswitch.backgroundColor = .clear
        return UIswitch
    }()
    
    let toMapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        button.setImage(UIImage(systemName: "globe.europe.africa"), for: .normal)
        button.setTitle("  View On Map", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        
        addSubview(cityLabel)
        addSubview(flagImageBorderView)
        addSubview(favoritedButton)
        addSubview(flagImageView)
        addSubview(willVisitLabel)
        addSubview(line1)
        addSubview(didVisitedLabel)
        addSubview(line2)
        addSubview(willVisitSwitch)
        addSubview(didVisitedSwitch)
        addSubview(backButton)
        addSubview(toMapButton)
        
        flagImageBorderView.topAnchor.constraint(equalTo: topAnchor, constant: -65).isActive = true
        flagImageBorderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        flagImageBorderView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        flagImageBorderView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        flagImageView.centerYAnchor.constraint(equalTo: flagImageBorderView.centerYAnchor).isActive = true
        flagImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 75).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        favoritedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoritedButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favoritedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        favoritedButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        
        willVisitLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30).isActive = true
        willVisitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28).isActive = true
        willVisitLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        willVisitLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        line1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line1.leadingAnchor.constraint(equalTo: willVisitLabel.leadingAnchor).isActive = true
        line1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        line1.topAnchor.constraint(equalTo: willVisitLabel.bottomAnchor, constant: 7).isActive = true
        
        didVisitedLabel.topAnchor.constraint(equalTo: willVisitLabel.bottomAnchor, constant: 20).isActive = true
        didVisitedLabel.leadingAnchor.constraint(equalTo: willVisitLabel.leadingAnchor).isActive = true
        didVisitedLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        didVisitedLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        line2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line2.leadingAnchor.constraint(equalTo: didVisitedLabel.leadingAnchor).isActive = true
        line2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        line2.topAnchor.constraint(equalTo: didVisitedLabel.bottomAnchor, constant: 7).isActive = true
        
        willVisitSwitch.centerYAnchor.constraint(equalTo: willVisitLabel.centerYAnchor).isActive = true
        willVisitSwitch.leadingAnchor.constraint(equalTo: willVisitLabel.trailingAnchor, constant: 50).isActive = true
        
        didVisitedSwitch.centerYAnchor.constraint(equalTo: didVisitedLabel.centerYAnchor).isActive = true
        didVisitedSwitch.leadingAnchor.constraint(equalTo: didVisitedLabel.trailingAnchor, constant: 50).isActive = true
        
        toMapButton.topAnchor.constraint(equalTo: didVisitedLabel.bottomAnchor, constant: 35).isActive = true
        toMapButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75).isActive = true
        toMapButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75).isActive = true
        toMapButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        backButton.topAnchor.constraint(equalTo: toMapButton.bottomAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75).isActive = true
        backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func configureCityInfo(with city: City) {
        guard let imageData = city.image else { return }
        cityLabel.text = city.name
        flagImageView.image = UIImage(data: imageData)
        
        switch city.willVisit {
        case true:
            willVisitSwitch.isOn = true
        case false:
            willVisitSwitch.isOn = false
        }
        
        switch city.didVisit {
        case true:
            didVisitedSwitch.isOn = true
        case false:
            didVisitedSwitch.isOn = false
        }
        
        switch city.isFavorited {
        case true:
            let image = UIImage (
                systemName: "heart.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
            )?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
            favoritedButton.setImage(image, for: .normal)
            favoritedButton.backgroundColor = .clear
        case false:
            let image = UIImage (
                systemName: "heart",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
            )?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
            favoritedButton.setImage(image, for: .normal)
            favoritedButton.backgroundColor = .clear
        }
    }
    
    func changeFavoriteButton(isFavorited: Bool) {
        switch isFavorited {
        case true:
            let image = UIImage (
                systemName: "heart.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
            )?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
            favoritedButton.setImage(image, for: .normal)
        case false:
            let image = UIImage (
                systemName: "heart",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
            )?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
            favoritedButton.setImage(image, for: .normal)
        }
    }
}
