//
//  BusinessViewModel.swift
//  MyUIKitProyect
//
//  Created by Fernando Corral on 6/1/22.
//

import UIKit
import CoreLocation

class BusinessViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    //MARK: - Constants
    
    let DISTANCE_FILTER: Int = 10000
    
    //MARK: - Properties
    let service = BusinessService()
    
    private var locationManager: CLLocationManager?
        
    var categorySelected: [BusinessCategory] = []
    
    var totalBusinessSelected = true
    
    var closedBusinessSelected = false
    
    var totalBusinessList: [BusinessModel] = []
    
    var businessList = [BusinessModel]()
    
    var location: CLLocation?
    
    var closedBusinessNumber: Int = 0
    
    //MARK: - Methods
    
    func loadBusiness(completion: @escaping ()-> Void) {
        service.callBack = nil
        checkIfLocationManagerEnabled()
        service.completionHandler { [weak self] (business, status, message) in
            if status {
                guard let self = self else { return }
                guard let businessData = business else { return }
                self.loadBusinessList(businessData: businessData)
            } else {
                print("Error: \(message)")
            }
            completion()
        }
    }
    
    func selectCategory(category: BusinessCategory, completion: @escaping () -> Void) {
        if self.categorySelected.contains(category) {
            if let index = categorySelected.firstIndex(where: { $0 == category }) {
                categorySelected.remove(at: index)
            }
        } else {
            self.categorySelected.append(category)
        }
        updateBusinessList()
        completion()
    }
    
    func allBusinessFilterSelected(completion: @escaping () -> Void) {
        totalBusinessSelected = true
        closedBusinessSelected = false
        resetCategoryFilter()
        completion()
    }
    
    func closedBusinessFilterSelected(completion: @escaping () -> Void) {
        totalBusinessSelected = false
        closedBusinessSelected = true
        resetCategoryFilter()
        completion()
    }
    
    func getClosedBusiness(distance: Double) {
        var closedBusienss:[BusinessModel] = []
        totalBusinessList.forEach({business in
            if business.distance < distance && business.distance > 0 {
                closedBusienss.append(business)
            }
        })
        businessList = closedBusienss.sorted(by: { $0.distance < $1.distance })
    }
    
    //MARK: - Private methods
    
    private func loadBusinessList(businessData: [BusinessDataModel]) {
        var closedNumber: Int = 0
        var business: [BusinessModel] = []
        businessData.forEach({ businessData in
            var bnss = BusinessModel(businessData: businessData)
            if let lat = bnss.latitude, let long = bnss.longitude, let userLocation = self.location {
                bnss.distance = CLLocation(latitude: lat, longitude: long).distance(from: userLocation).rounded()
            }
            if bnss.distance > 0 {
                if bnss.distance < Double(DISTANCE_FILTER) {
                    closedNumber += 1
                }
                business.append(bnss)
            }
        })
        self.businessList = business.sorted(by: { $0.distance < $1.distance })
        self.totalBusinessList = business.sorted(by: { $0.distance < $1.distance })
        self.closedBusinessNumber = closedNumber
    }
    
    private func resetCategoryFilter() {
        categorySelected = []
        if totalBusinessSelected {
            businessList = totalBusinessList
        } else {
            getClosedBusiness(distance: Double(DISTANCE_FILTER))
        }
    }
    
    private func updateBusinessList() {
        if totalBusinessSelected {
            self.businessList = totalBusinessList
            filterListByCategory()
        } else {
            getClosedBusiness(distance: Double(DISTANCE_FILTER))
            filterListByCategory()
        }
    }
    
    private func filterListByCategory() {
        var business: [BusinessModel] = []
            businessList.forEach({ bnss in
                if let currentCat = bnss.category , (categorySelected.contains(currentCat) || categorySelected.isEmpty) && bnss.distance > 0 {
                    business.append(bnss)
                }
            })
            self.businessList = business.sorted(by: { $0.distance < $1.distance })
    }
    
    //MARK: - Location Methods
    func checkIfLocationManagerEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationManagerAuthoritation()
            locationManager?.delegate = self
        }
    }
    
    private func checkLocationManagerAuthoritation() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            location = locationManager.location
            service.getBusiness()
        default:
            break
        }
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationManagerAuthoritation()
    }
}
