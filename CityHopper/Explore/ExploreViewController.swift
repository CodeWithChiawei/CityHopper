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

class ExploreViewController: UIViewController  {
    
    private let viewModel = ExploreViewModel()
    private let contentView = ExploreView()
    private lazy var currentLocation = LocationManager.shared.currentLocation
    private let haptics = UIImpactFeedbackGenerator(style: .medium)
    private let continentModel = Continent()
    private var previousSelectedIndex: IndexPath? = nil
    
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
        for index in 0..<continentModel.continentModelData.count {
            continentModel.continentModelData[index].isSelected = false
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
        let continent = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCellContinent.rawValue)
        
        if continent != nil {
            let loadingScreen = SimpleLoadingViewController()
            loadingScreen.modalPresentationStyle = .overFullScreen
            present(loadingScreen, animated: false)
            viewModel.fetchCity { [weak self] result in
                let cityViewControler = SelectViewController()
                cityViewControler.modalPresentationStyle = .fullScreen
                switch result {
                case .success(let city):
                    let cityViewControler = SelectViewController()
                    cityViewControler.modalPresentationStyle = .fullScreen
                    CityModelController.shared.exploreCity = city
                    self?.contentView.globeView.setCityPin(
                        with: city.latitude,
                        and: city.longitude
                    )
                    self?.present(cityViewControler, animated: true, completion: nil)
                    
                    self?.contentView.globeView.setCityPin(
                        with: city.latitude,
                        and: city.longitude
                    )
                    loadingScreen.dismiss(animated: true)
                    self?.contentView.globeView.globe?.camera.fly(
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
                        self?.haptics.impactOccurred()
                        self?.present(cityViewControler, animated: true)
                        self?.isUIUserInteratable(isActive: true)
                        self?.contentView.globeView.cityPointAnnotationManager?.annotations.removeAll()
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        } else {
            let alertController = UIAlertController(title: "No Continent Selected", message: "Please select a continent \n to explore new city.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(alertController, animated: true)
            isUIUserInteratable(isActive: true)
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
        guard let latitude = currentLocation?.coordinate.latitude,
              let longitude = currentLocation?.coordinate.longitude
        else { return }
        contentView.globeView.setUserLocationPin(with: latitude, and: longitude)
    }
}


extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return continentModel.continentModelData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let continentData = continentModel.continentModelData[indexPath.row]
        guard let cell = contentView.collectionView.dequeueReusableCell(
            withReuseIdentifier: ContinentSeletionCollectionCell.identifier,
            for: indexPath) as? ContinentSeletionCollectionCell else {
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
        continentModel.continentModelData[indexPath.row].isSelected = true
        if let previousSelectedIndex = previousSelectedIndex, indexPath != previousSelectedIndex {
            continentModel.continentModelData[previousSelectedIndex.row].isSelected = false
            collectionView.reloadItems(at: [previousSelectedIndex])
            continentModel.continentModelData[indexPath.row].isSelected = true
            collectionView.reloadItems(at: [indexPath])
            self.previousSelectedIndex = indexPath
        } else {
            previousSelectedIndex = indexPath
            continentModel.continentModelData[indexPath.row].isSelected = true
            collectionView.reloadItems(at: [indexPath])
        }
        UserDefaults.standard.set(continentModel.continentModelData[indexPath.row].continent, forKey: UserDefaultKeys.selectedCellContinent.rawValue)
    }
}

