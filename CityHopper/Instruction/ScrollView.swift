//
//  ScrollView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/2/23.
//

import Foundation
import UIKit

class InstructionScrollView: UIScrollView {
        
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Instruction"
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Explore
    
    private let exploreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1. Explore"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    private let line1: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    private let exploreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "instruction1")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    private let exploreInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.clipsToBounds = true
        label.text =
        "- Swipe through the continents to view more.\n - Select the continent box of your desired travel destination.\n - Tap “Explore” after selecting a continent. A random city from the selected continent will be chosen."
        return label
    }()
    
    // MARK: - Choice
    
    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2. Choose"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    private let line2: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    private let choiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "instruction2")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let selectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.clipsToBounds = true
        label.text =
        "- You will be allowed to add the place to your future destination list or mark it as visited. If you prefer neither of these options, you can explore a new city from the same continent."
        return label
    }()
    
    // MARK: - View
    
    
    private let listLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3. View"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    private let line3: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    private let listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "instruction3")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let globeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "instruction4")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
   
    private let viewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.text =
        "- On the view screen, all of your future destination, visited and favortied cities will be display.\n- All the cities will be shown on the Map View.\n- Selecting a city from list allows you to edit it or zoom on the map."
        return label
    }()
    
    // MARK: - SetUp
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.contentSize = CGSize(width: frame.width, height: 1670 )
        showsVerticalScrollIndicator = true
        indicatorStyle = .black
        isScrollEnabled = true
        setConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setConstraints() {
        
        addSubview(instructionLabel)
        addSubview(exploreLabel)
        addSubview(line1)
        addSubview(exploreImageView)
        addSubview(exploreInfoLabel)
        addSubview(choiceLabel)
        addSubview(line2)
        addSubview(choiceImageView)
        addSubview(selectLabel)
        addSubview(listLabel)
        addSubview(line3)
        addSubview(listImageView)
        addSubview(globeImageView)
        addSubview(viewLabel)
        
        instructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        instructionLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        instructionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        exploreLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20).isActive = true
        exploreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        exploreLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        exploreLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // line1 constraints
        line1.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 5).isActive = true
        line1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        line1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // exploreImageView constraints
        exploreImageView.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 17).isActive = true
        exploreImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        exploreImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        exploreImageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        exploreInfoLabel.topAnchor.constraint(equalTo: exploreImageView.bottomAnchor, constant: 20).isActive = true
        exploreInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        exploreInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        exploreInfoLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        // choiceLabel constraints
        choiceLabel.topAnchor.constraint(equalTo: exploreInfoLabel.bottomAnchor, constant: 20).isActive = true
        choiceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        choiceLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        choiceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // line2 constraints
        line2.topAnchor.constraint(equalTo: choiceLabel.bottomAnchor, constant: 5).isActive = true
        line2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line2.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        line2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // choiceImageView constraints
        choiceImageView.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 17).isActive = true
        choiceImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        choiceImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        choiceImageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        selectLabel.topAnchor.constraint(equalTo: choiceImageView.bottomAnchor, constant: 20).isActive = true
        selectLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        selectLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectLabel.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        // listLabel constraints
        listLabel.topAnchor.constraint(equalTo: selectLabel.bottomAnchor, constant: 20).isActive = true
        listLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        listLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        listLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // line3 constraints
        line3.topAnchor.constraint(equalTo: listLabel.bottomAnchor, constant: 5).isActive = true
        line3.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        line3.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        line3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        // listImageView constraints = true
        listImageView.topAnchor.constraint(equalTo: line3.bottomAnchor, constant: 17).isActive = true
        listImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.46).isActive = true
        listImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.46).isActive = true
        listImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        // globeImageView constraints = true
        globeImageView.topAnchor.constraint(equalTo: line3.bottomAnchor, constant: 17).isActive = true
        globeImageView.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: 5).isActive = true
        globeImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.46).isActive = true
        globeImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.46).isActive = true
        // editLabel constraints = true
        viewLabel.topAnchor.constraint(equalTo: globeImageView.bottomAnchor, constant: 20).isActive = true
        viewLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        viewLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewLabel.heightAnchor.constraint(equalToConstant: 115).isActive = true
    }
}

