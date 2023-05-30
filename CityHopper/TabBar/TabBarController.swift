//
//  TabBarController.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//
import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let topSeperationLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        constraints()
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        let searchViewController = ExploreViewController()
        searchViewController.title = "Explore"
        searchViewController.tabBarItem.image = UIImage(systemName: "globe.asia.australia.fill")
        
        let savedListViewController = SavedCityViewController()
        savedListViewController.title = "View"
        savedListViewController.tabBarItem.image = UIImage(systemName: "book")
        
        let instructionViewController = InstructionViewController()
        instructionViewController.title = "Instruction"
        instructionViewController.tabBarItem.image = UIImage(systemName: "info.circle")
        
        
        self.setViewControllers([searchViewController, savedListViewController, instructionViewController], animated: false)
        self.selectedIndex = 0
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .selected)
    }
    
    private func constraints() {
        view.addSubview(topSeperationLine)
        
        topSeperationLine.centerYAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        topSeperationLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topSeperationLine.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topSeperationLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
