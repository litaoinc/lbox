//
//  ViewController.swift
//  RichEditorViewSample
//
//  Created by Caesar Wirth on 4/5/15.
//  Copyright (c) 2015 Caesar Wirth. All rights reserved.
//

import UIKit
import Log

class CSNoteViewController : UIViewController {
    private static let kWeatherAPIUrl = "https://api.openweathermap.org/data/2.5/weather"
    private static let kWeatherIconUrl = "https://openweathermap.org/img/w/"
    private static let kWeatherAppId = "33820a3b430a624ec1161a1fd511f40b"
    
    let logger = Logger()
    var locationManager = BMKLocationManager()
    var lat : Double = 0.0
    var lon : Double = 0.0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var wetherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        requestLocation()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        locationLabel.addGestureRecognizer(singleTap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestWeather()
        requestDate()
    }
    
    func requestDate() {
        let now = Date.init()
        dateLabel.text = String(now.description.split(separator: " ")[0])
    }
    
    @objc
    func handleSingleTap(_ tap : UITapGestureRecognizer) {
        if tap.view?.tag == 0 {//tap locate label
            let option = BMKPOINearbySearchOption()
            option.pageIndex = 0
            option.pageSize = 10
            option.radius = 1000
            option.keywords = ["地标"]
            option.location.latitude = self.lat
            option.location.longitude = self.lon
            
            let search = BMKPoiSearch()
            search.delegate = self
            search.poiSearchNear(by: option)
        }
    }
    
    private func requestLocation() {
        locationManager.coordinateType = BMKLocationCoordinateType.BMK09LL
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.automotiveNavigation
        locationManager.pausesLocationUpdatesAutomatically = true
        
        locationManager.requestLocation(withReGeocode: true, withNetworkState: true,completionBlock: { (location:BMKLocation?, locationState:BMKLocationNetworkState, error:Error?) in
            
            if error != nil {
                self.logger.error(error!.localizedDescription)
                return
            }
            
            self.lat = location!.location!.coordinate.latitude
            self.lon = location!.location!.coordinate.longitude
        })
    }
    
    func requestWeather() {
        let manager = AFHTTPSessionManager()
        let param = ["lat":self.lat, "lon":self.lon, "lang":"zh_cn", "APPID":CSNoteViewController.kWeatherAppId] as [String : Any]
        manager.get(CSNoteViewController.kWeatherAPIUrl, parameters: param, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            let temp = (response as! NSDictionary)["main"] as! NSDictionary
            let weat = ((response as! NSDictionary)["weather"] as! NSArray)[0] as! NSDictionary
            
            //print("https://openweathermap.org/img/w/\(weat["icon"]!).png")
            DispatchQueue.global().async {
                let icon = try? Data(contentsOf: URL(string:CSNoteViewController.kWeatherIconUrl + "\(weat["icon"]!).png")!)
                if let icon = icon {
                    DispatchQueue.main.sync {
                        self.weatherImg.image = UIImage(data: icon)
                    }
                }
            }
            
            self.wetherLabel.text = "\(weat["description"]!)"
            
            let tempc = Int(truncating: temp["temp"] as! NSNumber) - 273
            self.tempLabel.text = "\(tempc)℃"
        }) { (task : URLSessionDataTask?
            , error : Error) in
            self.logger.error(error.localizedDescription)
            return
        }
    }
}

extension CSNoteViewController : BMKPoiSearchDelegate {
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPOISearchResult!, errorCode: BMKSearchErrorCode) {
        let poiSheet = UIAlertController(title: "Choose Place", message: "", preferredStyle: .actionSheet)
        poiResult.poiInfoList.map { (poi : BMKPoiInfo) in
            poiSheet.addAction(UIAlertAction(title: poi.name, style: .default, handler: {
                (action : UIAlertAction) -> Void in
                self.locationLabel.text = action.title
            }))
        }

        poiSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(poiSheet, animated: true, completion: nil)
    }
}
