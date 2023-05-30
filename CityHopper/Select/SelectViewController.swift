//
//  CityLottery.swift
//  TripCity
//
//  Created by chiawei wen on 3/11/23.
//

import Foundation
import UIKit

class SelectViewController: UIViewController {
    
    //ViewModel should be private
    private let viewModel = SelectViewModel()
    private let contentView = SelectView()
    private let haptics = UIImpactFeedbackGenerator(style: .light)

    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CityModelController.shared.retrieveData {}
        setButtonTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.assignCityModelData()
        let selectionInstructionVC = SelectInstructionViewController()
        configureCityData()
        selectionInstructionVC.modalPresentationStyle = .overFullScreen
        let isFirstTimeUser = UserDefaults().bool(forKey: UserDefaultKeys.firstTimeUse.rawValue)
        if isFirstTimeUser == false {
            present(selectionInstructionVC, animated: false)
        }
    }
    
    private func setButtonTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.addToFutureVisitButton.addTarget(self, action: #selector(addToFutureButtonTapped), for: .touchUpInside)
        contentView.addToVisitedButton.addTarget(self, action: #selector(addToVisitedButtonTapped), for: .touchUpInside)
        contentView.regenerateButton.addTarget(self, action: #selector(regenerateButtonTapped), for: .touchUpInside)
    }
    
    private func configureCityData() {
        guard let city = viewModel.cityModelData?.cityName,
              let countryCode = viewModel.cityModelData?.countryCode,
              let latitude = viewModel.cityModelData?.latitude,
              let longitude = viewModel.cityModelData?.longitude
        else { return }
        
        contentView.configure(with: city, and: countryCode)
        contentView.setupMap(with: latitude, and: longitude)
        
        if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == latitude && $0.longitude == longitude }) {
            viewModel.cityData = existingCity
        } else {
            guard let newCity = viewModel.cityModelData else { return }
            viewModel.assignCity(newCity: newCity)
        }
    }
    
    @objc
    private func backButtonTapped() {
        haptics.impactOccurred()
        dismiss(animated: true)
    }
    
    // MARK: - WillVisit
    
    @objc
    private func addToFutureButtonTapped() {
        
        haptics.impactOccurred()
        
        guard let city = viewModel.cityData else { return }
        city.willVisit = true
        if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == city.latitude && $0.longitude == city.longitude }) {
            CityModelController.shared.updateCityWillVisit(city: existingCity, willVisit: city.willVisit)
        }
        self.regenerate(visited: false, cityName: city.name ?? "")
    }
    
    // MARK: - Visited
    
    @objc
    private func addToVisitedButtonTapped() {
        haptics.impactOccurred()
        let selfController = SelectViewController()
        
        guard let city = viewModel.cityData else { return }
        city.didVisit = true
        if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == city.latitude && $0.longitude == city.longitude }) {
            CityModelController.shared.updateCityIDidVisit(city: existingCity, didVisit: city.didVisit)
        }
        
        navigationController?.pushViewController(selfController, animated: false)
        regenerate(visited: true, cityName: city.name ?? ""  )
    }
    
    
    // MARK: - Regenerate
    
    @objc
    private func regenerateButtonTapped() {
        regenerate(visited: true, cityName: "")
        haptics.impactOccurred()
    }
    
    private func regenerate(visited: Bool, cityName: String) {
        let loadingScreen = RegenerateLoadingViewController()
        loadingScreen.city = cityName
        loadingScreen.isVisited = visited
        loadingScreen.modalTransitionStyle = .crossDissolve
        loadingScreen.modalPresentationStyle = .overFullScreen
        present(loadingScreen, animated: true) { [weak self] in
            self?.viewModel.fetchCity { [weak self] result in
                switch result {
                case .success(let city):
                    self?.contentView.configure(with: city.name, and: city.countryCode)
                    self?.contentView.setupMap(with: city.latitude, and: city.longitude)
                    
                    if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == city.latitude && $0.longitude == city.longitude }) {
                        self?.viewModel.cityData = existingCity
                    } else {
                        guard let newCity = self?.viewModel.cityModelData else { return }
                        self?.viewModel.assignCity(newCity: newCity)
                    }
                case .failure(let error):
                    print(error)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                loadingScreen.dismiss(animated: true)
            }
        }
    }
}
