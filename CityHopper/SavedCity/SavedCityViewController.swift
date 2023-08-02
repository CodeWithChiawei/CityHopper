//
//  ChoiceViewController.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//

import Foundation
import UIKit
import MapboxMaps

class SavedCityViewController: UIViewController {
    
    private let contentView = SavedCityView()
    private let viewModel = SavedCityViewModel()
    private let haptics = UIImpactFeedbackGenerator(style: .light)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.listView.tableView.delegate = self
        contentView.listView.tableView.dataSource = self
        contentView.mapView.globe.annotations.makePointAnnotationManager().delegate = self
        segmentControlTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.listView.tableView.reloadData()
        CityModelController.shared.retrieveData{ [weak self] in
            self?.handleSelectedSegmentIndex(0)
        }
    }
    
    private func segmentControlTargets() {
        contentView.viewTypeSegmentedControl.addTarget(self, action: #selector(viewSegmentedControlChanged), for: .valueChanged)
        contentView.mapSegmentedControl.addTarget(self, action: #selector(mapCollectionSegmentedControlChanged), for: .valueChanged)
        contentView.listSegmentedControl.addTarget(self, action: #selector(listCollectionSegmentedControlChanged), for: .valueChanged)
    }
    
    
    // MARK: - SEGMENTED CONTROL SWITCH
    
    @objc
    private func viewSegmentedControlChanged () {
        let selectedIndex = contentView.viewTypeSegmentedControl.selectedSegmentIndex
        contentView.switchStyleSegment(with: selectedIndex)
    }
    
    @objc
    private func listCollectionSegmentedControlChanged () {
        let selectedIndex = contentView.listSegmentedControl.selectedSegmentIndex
        handleSelectedSegmentIndex(selectedIndex)
    }
    
    @objc
    private func mapCollectionSegmentedControlChanged () {
        let selectedIndex = contentView.mapSegmentedControl.selectedSegmentIndex
        handleSelectedSegmentIndex(selectedIndex)
    }
    
    private func handleSelectedSegmentIndex(_ selectedIndex: Int) {
        viewModel.filterData(with: CityModelController.shared.cities, by: selectedIndex)
        contentView.switchTypeSegment(with: selectedIndex, cityData: viewModel.cityData)
        }
}

// MARK: - TABLE_VIEW

extension SavedCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SavedCityTableViewCell.identifier,
            for: indexPath) as? SavedCityTableViewCell else
        { return UITableViewCell() }
        
        let cityData = viewModel.cityData[indexPath.row]
        guard let imageData = cityData.image, let cityName = cityData.name else { return UITableViewCell()}
       
        cell.configCell(
            imageData: imageData,
            cityName: cityName,
            isCityFavorited: cityData.isFavorited
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        haptics.impactOccurred()
        let cityProfileVC = ProfileViewController()
        let cityData = viewModel.cityData[indexPath.row]
        cityProfileVC.modalPresentationStyle = .overCurrentContext
        cityProfileVC.modalTransitionStyle = .crossDissolve
        CityModelController.shared.city = cityData
        cityProfileVC.delegate = self
        tableView.deselectRow(at: indexPath, animated: true)
        present(cityProfileVC, animated: true)
    }
}

extension SavedCityViewController: ProfileViewControllerDelegate {
    func cityDataDidUpdate() {
        if contentView.listSegmentedControl.selectedSegmentIndex == 0 {
            viewModel.filterData(with: CityModelController.shared.cities, by: 0)
        } else if contentView.listSegmentedControl.selectedSegmentIndex == 1 {
            viewModel.filterData(with: CityModelController.shared.cities, by: 1)
        } else if contentView.listSegmentedControl.selectedSegmentIndex == 2 {
            viewModel.filterData(with: CityModelController.shared.cities, by: 2)
        }
        if let existingCity = CityModelController.shared.cities.first(where: { $0.didVisit == false && $0.willVisit == false}) {
            CityModelController.shared.deleteCity(city: existingCity)
        }
        contentView.mapView.setPins(with: viewModel.cityData)
        contentView.listView.tableView.reloadData()
    }
}

extension SavedCityViewController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: MapboxMaps.AnnotationManager, didDetectTappedAnnotations annotations: [MapboxMaps.Annotation]) {}
}
