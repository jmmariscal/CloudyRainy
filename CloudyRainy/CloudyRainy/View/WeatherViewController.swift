//
//  WeatherViewController.swift
//  CloudyRainy
//
//  Created by Juan M Mariscal on 6/24/21.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherController = ForecastResultController()
    var weather: Forecast?
    
    // MARK: IBOutlets
    @IBOutlet weak var currentDegreesLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        updateViews()
    }
    
    private func updateViews() {
        guard let weather = weather else { return }
        
        cityLabel.text = weather.name
        currentDegreesLabel.text = String(weather.main.temp)
//        currentDegreesLabel.text = weather.cityTemp.map({ $0.cityTemp.temp.capitalized })
        weatherDescriptionLabel.text = weather.weather.description
    }

}

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        print("Search Bar clicked")
        weatherController.searchWeatherByCity(searchTerm: searchTerm) { (result) in
            do {
                let weather = try result.get()
                DispatchQueue.main.async {
                    self.weather = weather
                    self.updateViews()
                }
            } catch {
                print("\(error)")
            }
        }
    }
}
