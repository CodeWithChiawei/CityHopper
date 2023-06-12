//
//  SelectInstructionView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/17/23.

import Foundation
import UIKit

class GeneratedCityInstructionView: UIView {
    
    private var imageViewCenterXConstraint: NSLayoutConstraint?
    private var imageViewBottomConstraint: NSLayoutConstraint?
    private let label = UILabel()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    private let addToFutureVisitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "suitcase.rolling.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 39
        button.addShadow()
        return button
    }()
    
    private let regenerateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "arrow.counterclockwise",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 30
        button.addShadow()
        return button
    }()
    
    private let addToVisitedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "mappin.and.ellipse",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 45).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 39
        button.addShadow()
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "house.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 30
        button.addShadow()
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next ➜", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25) // Set the desired font size
        button.backgroundColor = .black.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "Tap here to add the city\n to your future destination"
        label.layer.borderWidth = 1.5
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "instructionArrow")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        backgroundColor = .systemGray.withAlphaComponent(0.8)
        addToVisitedButton.isHidden = true
        regenerateButton.isHidden = true
        backButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        addSubview(cityLabel)
        addSubview(addToFutureVisitButton)
        addSubview(label)
        addSubview(backButton)
        addSubview(regenerateButton)
        addSubview(addToVisitedButton)
        addSubview(usageLabel)
        addSubview(imageView)
        addSubview(nextButton)
        
        cityLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: addToFutureVisitButton.topAnchor, constant: -40).isActive = true
        
        regenerateButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        regenerateButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 45).isActive = true
        regenerateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        regenerateButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        backButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -45).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addToFutureVisitButton.trailingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: -15).isActive = true
        addToFutureVisitButton.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -40).isActive = true
        addToFutureVisitButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        addToFutureVisitButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        addToVisitedButton.leadingAnchor.constraint(equalTo: regenerateButton.trailingAnchor, constant: 15).isActive = true
        addToVisitedButton.centerYAnchor.constraint(equalTo: addToFutureVisitButton.centerYAnchor).isActive = true
        addToVisitedButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        addToVisitedButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        nextButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        usageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        usageLabel.heightAnchor.constraint(equalToConstant: 115).isActive = true
        usageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        usageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
        imageView.topAnchor.constraint(equalTo: usageLabel.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewCenterXConstraint = imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -129)
        imageViewCenterXConstraint?.isActive = true
        imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -150)
        imageViewBottomConstraint?.isActive = true
    }
    
    func viewConfig(with pageCount: Int) {
        switch pageCount {
        case 2:
            addToFutureVisitButton.isHidden = true
            addToVisitedButton.isHidden = true
            backButton.isHidden = false
            regenerateButton.isHidden = true
            imageViewCenterXConstraint?.constant = -45
            imageViewBottomConstraint?.constant += 40
            usageLabel.text = "Tap here to go back to home page"
        case 3:
            addToFutureVisitButton.isHidden = true
            addToVisitedButton.isHidden = true
            backButton.isHidden = true
            regenerateButton.isHidden = false
            imageViewCenterXConstraint?.constant = 45
            usageLabel.text = "Tap here for new city from same continent"
        case 4:
            addToFutureVisitButton.isHidden = true
            addToVisitedButton.isHidden = false
            backButton.isHidden = true
            regenerateButton.isHidden = true
            imageViewCenterXConstraint?.constant = 129
            imageViewBottomConstraint?.constant -= 40
            usageLabel.text = "Tap here to add the city\n to your visited list"
            
        default:
            UserDefaults().set(true, forKey: UserDefaultKeys.firstTimeUse.rawValue)
        }
    }
}
