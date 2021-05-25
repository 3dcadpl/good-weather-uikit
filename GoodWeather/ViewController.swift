//
//  ViewController.swift
//  GoodWeather
//
//  Created by Paweł Andrzejewski on 24/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = URLSessionForecastProvider()
        provider.getForecast(for: "warsaw", callback: onForecastLoaded)
    }

    private func onForecastLoaded(result: Result<Forecast, ForecastProviderError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let forecast):
                print(forecast.city)
            case .failure(let error):
                print(error)
            }
        }
       
    }
    
}

