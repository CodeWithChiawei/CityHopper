//
//  CityUpdateViewController.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//

import Foundation
import UIKit
import MapboxMaps

protocol ProfileDelegate: AnyObject {
    func cityDataDidUpdate()
}

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileDelegate?
    private let viewModel = ProfileViewModel()
    private let contentView = ProfileView()
    private let haptics = UIImpactFeedbackGenerator(style: .light)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.city = CityModelController.shared.profileCity
        guard let city = viewModel.city else { return }
        contentView.containerView.configureCityInfo(with: city)
        contentView.configView()
    }
    
    private func addTargets() {
        contentView.containerView.willVisitSwitch.addTarget(self, action: #selector(willVisitSwitchTapped(_:)), for: .valueChanged)
        contentView.containerView.didVisitedSwitch.addTarget(self, action: #selector(visitedSwitchTapped(_:)), for: .valueChanged)
        contentView.containerView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.containerView.toMapButton.addTarget(self, action: #selector(toMapButtonTapped), for: .touchUpInside)
        contentView.containerView.favoritedButton.addTarget(self, action: #selector(favoritedButtonTapped), for: .touchUpInside)
    }
    
    private func setGestures() {
        let backToProfileTapped = UITapGestureRecognizer(
            target: self,
            action: #selector(backToProfileButtonTapped)
        )
        contentView.backToProfileButton.addGestureRecognizer(backToProfileTapped)
        
        let dismissGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(clearBackgroundTapped)
        )
        contentView.blurEffiectView.addGestureRecognizer(dismissGesture)
    }
    
    // MARK: - @OBJC FUNC
    
    @objc
    private func favoritedButtonTapped() {
        haptics.impactOccurred()
        if viewModel.city?.isFavorited == true {
            viewModel.city?.isFavorited = false
            contentView.containerView.changeFavoriteButton(isFavorited: false)
        } else {
            viewModel.city?.isFavorited = true
            contentView.containerView.changeFavoriteButton(isFavorited: true)
        }
        viewModel.updateCity()
        CityModelController.shared.retrieveData { [weak self] in
            self?.delegate?.cityDataDidUpdate()
        }
    }
    
    @objc
    private func willVisitSwitchTapped(_ sender: UISwitch) {
        haptics.impactOccurred()

        if sender.isOn {
            viewModel.city?.willVisit = true
        } else {
            viewModel.city?.willVisit = false
        }
        viewModel.updateCity()
        CityModelController.shared.retrieveData { [weak self] in
            self?.delegate?.cityDataDidUpdate()
        }
    }
    
    @objc
    private func visitedSwitchTapped(_ sender: UISwitch) {
        haptics.impactOccurred()
        if sender.isOn {
            viewModel.city?.didVisit = true
        } else {
            viewModel.city?.didVisit = false
        }
        viewModel.updateCity()
        CityModelController.shared.retrieveData { [weak self] in
            self?.delegate?.cityDataDidUpdate()
        }
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
        haptics.impactOccurred()
    }
    
    @objc
    private func clearBackgroundTapped() {
        dismiss(animated: true)
        haptics.impactOccurred()
    }
    
    @objc
    private func toMapButtonTapped() {
        guard let city = viewModel.city else { return }
        contentView.changeToMapView(cityData: city)
        haptics.impactOccurred()
    }
    
    @objc
    private func backToProfileButtonTapped() {
        contentView.backtoContainerView()
        haptics.impactOccurred()
    }
    
    @objc
    private func backToListButtonTapped() {
        dismiss(animated: true)
        haptics.impactOccurred()
    }
}
