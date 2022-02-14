//
//  Interactor.swift
//  CountryViper
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation

protocol CountryInteractor {
    var presenter : CountryPresenter? {get set}
    
    func downloadCountries()
}

class CountryClassInteractor : CountryInteractor {
    var presenter: CountryPresenter?
    
    func downloadCountries() {
        guard let url = URL(string: "https://raw.githubusercontent.com/hamitseyrek/CountryViper/hamitseyrek/countries.json") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCountry(result: .failure(NetworkError.NetworkError))
                return
            }
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                self?.presenter?.interactorDidDownloadCountry(result: .success(countries))
            }catch {
                self?.presenter?.interactorDidDownloadCountry(result: .failure(NetworkError.ParsingError))
            }
        }
        task.resume()
    }
}
