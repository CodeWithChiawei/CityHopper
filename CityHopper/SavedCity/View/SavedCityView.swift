//
//  ChoiceView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//

import Foundation
import UIKit

class SavedCityView: UIView {
    
    let listView = SavedCityListView()
    let mapView = SavedCityMapView()
    
    let viewTypeSegmentedControl: UISegmentedControl = .create(withItems: ["List View", "Map View"], selectedIndex: 0)
    let mapSegmentedControl: UISegmentedControl = .create(withItems: ["Future", "Visited", "Favorite"], selectedIndex: 0)
    let listSegmentedControl: UISegmentedControl = .create(withItems: ["Future", "Visited", "Favorite"], selectedIndex: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        mapView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(listView)
        addSubview(mapView)
        addSubview(viewTypeSegmentedControl)
        addSubview(listSegmentedControl)
        addSubview(mapSegmentedControl)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        listView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        viewTypeSegmentedControl.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15).isActive = true
        viewTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        viewTypeSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        viewTypeSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        
        mapSegmentedControl.topAnchor.constraint(equalTo: viewTypeSegmentedControl.bottomAnchor, constant: 15).isActive = true
        mapSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mapSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        mapSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        
        listSegmentedControl.topAnchor.constraint(equalTo: viewTypeSegmentedControl.bottomAnchor, constant: 15).isActive = true
        listSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        listSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        listSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40).isActive = true
        
    }
    
    func switchStyleSegment(with index: Int) {
        switch index {
        case 0:
            mapView.isHidden = true
            mapSegmentedControl.isHidden = true
            listView.isHidden = false
            listSegmentedControl.isHidden = false
            mapView.removeAnnotation()
        case 1:
            mapView.isHidden = false
            mapSegmentedControl.isHidden = false
            listView.isHidden = true
            listSegmentedControl.isHidden = true
            mapView.removeAnnotation()
        default:
            break
        }
    }
    
    func switchTypeSegment(with index: Int, cityData: [City]) {
        switch index {
        case 0:
            mapSegmentedControl.selectedSegmentIndex = 0
            listSegmentedControl.selectedSegmentIndex = 0
            mapView.selectedIndex = 0
            listView.tableView.reloadData()
            listView.backgroundImageView.image = UIImage(named: "favoritedBackground")
            mapView.setPins(with: cityData)
            mapView.removeAnnotation()
        case 1:
            mapSegmentedControl.selectedSegmentIndex = 1
            listSegmentedControl.selectedSegmentIndex = 1
            mapView.selectedIndex = 1
            self.listView.backgroundImageView.image = UIImage(named: "river")
            listView.tableView.reloadData()
            mapView.setPins(with: cityData)
            mapView.removeAnnotation()
        case 2:
            mapSegmentedControl.selectedSegmentIndex = 2
            listSegmentedControl.selectedSegmentIndex = 2
            mapView.selectedIndex = 2
            self.listView.backgroundImageView.image = UIImage(named: "paris")
            listView.tableView.reloadData()
            mapView.setPins(with: cityData)
            mapView.removeAnnotation()
        default:
            break
        }
    }
    
}

