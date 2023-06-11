//
//  SearchViewController.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//

import Foundation
import UIKit
import MapboxMaps
import CoreData
import CoreLocation
import AppTrackingTransparency

class ContinentGlobeViewController: UIViewController  {
    
    private let viewModel = ContinentGlobeViewModel()
    private let contentView = ContinentGlobeView()
    private let continentData = ContinentData()
    private var previousSelectedIndex: IndexPath? = nil
    private let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        //        deleteAll()
        contentView.exploreButton.addTarget(self, action: #selector(exploreButtonTapped), for: .touchUpInside)
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.collectionView.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.exploreButton.backgroundColor = .cyan.withAlphaComponent(0.8)
        UserDefaults.standard.set(nil, forKey: UserDefaultKeys.selectedCellContinent.rawValue)
        contentView.collectionView.reloadData()
        contentView.globeView.startDisplayGlobeSpin()
        isUIUserInteratable(isActive: true)
        setUserPin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAppTrackingTransparency()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for index in 0..<continentData.continentModelData.count {
            continentData.continentModelData[index].isSelected = false
        }
        previousSelectedIndex = nil
        contentView.globeView.stopDisplayLink()
    }
    
    private func requestAppTrackingTransparency() {
        ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
            switch status {
            case .restricted, .denied, .notDetermined, .authorized:
                break
            @unknown default:
                break
            }
        })
    }
    
    @objc
    private func exploreButtonTapped() {
        haptics.impactOccurred()
        isUIUserInteratable(isActive: false)
        guard let _ = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCellContinent.rawValue) else {
            self.presentNoContinentSelectedAlert()
            return
        }
        let loadingScreen = SimpleLoadingViewController()
        presentLoadingScreen(loadingScreen: loadingScreen)
        viewModel.fetchCity { [weak self] result in
            switch result {
            case .success(let city):
                self?.handleSuccessFetch(city: city,
                                         loadingScreen: loadingScreen
                )
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func presentNoContinentSelectedAlert() {
        let alertController = UIAlertController(title: "No Continent Selected", message: "Please select a continent \n to explore new city.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alertController, animated: true)
        isUIUserInteratable(isActive: true)
    }
    
    private func presentLoadingScreen(loadingScreen: UIViewController) {
        loadingScreen.modalPresentationStyle = .overFullScreen
        loadingScreen.modalTransitionStyle = .crossDissolve
        present(loadingScreen, animated: false)
    }
    
    private func handleSuccessFetch(city: FetchCityModel, loadingScreen: UIViewController) {
        CityModelController.shared.exploreCity = city
        contentView.globeView.setCityPin(
            with: city.latitude,
            and: city.longitude
        )
        contentView.globeView.setCityPin(
            with: city.latitude,
            and: city.longitude
        )
        loadingScreen.dismiss(animated: true)
        contentView.globeView.globe.camera.fly(
            to: CameraOptions(
                center: CLLocationCoordinate2D(
                    latitude: city.latitude,
                    longitude: city.longitude
                ),
                zoom: 3,
                bearing: 0
            ),
            duration: 1.5
        ) { [weak self] _ in
            let cityViewControler = GeneratedCityViewController()
            cityViewControler.modalPresentationStyle = .fullScreen
            self?.haptics.impactOccurred()
            self?.present(cityViewControler, animated: true)
            self?.isUIUserInteratable(isActive: true)
            self?.contentView.globeView.cityPointAnnotationManager.annotations.removeAll()
        }
    }
    
    private func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? CoreDataStack.context.execute(batchDeleteRequest1)
    }
    
    private func isUIUserInteratable(isActive :Bool) {
        contentView.exploreButton.isUserInteractionEnabled = isActive
        contentView.collectionView.isUserInteractionEnabled = isActive
        switch isActive {
        case true:
            contentView.exploreButton.backgroundColor = .cyan
        case false:
            contentView.exploreButton.backgroundColor = .systemGray
        }
    }
    
    private func setUserPin() {
        guard let latitude = LocationManager.shared.currentLocation?.coordinate.latitude,
              let longitude = LocationManager.shared.currentLocation?.coordinate.longitude
        else { return }
        contentView.globeView.setUserLocationPin(with: latitude, and: longitude)
    }
}


extension ContinentGlobeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return continentData.continentModelData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let continentData = continentData.continentModelData[indexPath.row]
        guard let cell = contentView.collectionView.dequeueReusableCell(
            withReuseIdentifier: ContinentGlobeCollectionCell.identifier,
            for: indexPath) as? ContinentGlobeCollectionCell else {
            return UICollectionViewCell()
        }
        cell.cellConfigures(backgroundColor: continentData.color,
                            continentImage: continentData.image ?? UIImage(),
                            continentName: continentData.continent,
                            isSelected: continentData.isSelected
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        continentData.continentModelData[indexPath.row].isSelected = true
        if let previousSelectedIndex = previousSelectedIndex, indexPath != previousSelectedIndex {
            continentData.continentModelData[previousSelectedIndex.row].isSelected = false
            collectionView.reloadItems(at: [previousSelectedIndex])
            continentData.continentModelData[indexPath.row].isSelected = true
            collectionView.reloadItems(at: [indexPath])
            self.previousSelectedIndex = indexPath
        } else {
            previousSelectedIndex = indexPath
            continentData.continentModelData[indexPath.row].isSelected = true
            collectionView.reloadItems(at: [indexPath])
        }
        UserDefaults.standard.set(continentData.continentModelData[indexPath.row].continent, forKey: UserDefaultKeys.selectedCellContinent.rawValue)
    }
}

