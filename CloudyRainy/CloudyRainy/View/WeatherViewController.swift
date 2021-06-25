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
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    func convertToF(_ temp: Double) -> Double {
        let celcius = temp - 273.5
        return celcius * 9 / 5 + 32
    }
    
    private func updateViews() {
        guard let weather = weather else { return }
        
        let tempInF: String = numberFormatter.string(for: convertToF(weather.main.temp)) ?? "0"

        cityLabel.text = weather.name
        currentDegreesLabel.text = tempInF
        weatherDescriptionLabel.text = String(weather.weather[0].description.capitalized)
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
