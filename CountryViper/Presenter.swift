//
//  Presenter.swift
//  CountryViper
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation

enum NetworkError : Error {
    case NetworkError
    case ParsingError
}

protocol CountryPresenter {
    var router : CountryRouter? {get set}
    var interactor : CountryInteractor? {get set}
    var view : CountryView? {get set}
    
    func interactorDidDownloadCountry(result : Result<[Country],Error>)
}

class CountryClassPresenter : CountryPresenter {
    var router: CountryRouter?
    
    var interactor: CountryInteractor? {
        didSet {
            interactor?.downloadCountries()
        }
    }
    
    var view: CountryView?
    
    func interactorDidDownloadCountry(result: Result<[Country], Error>) {
        switch result {
        case .success(let countries):
            view?.update(with: countries)
        case .failure(_):
            view?.update(with: "Try again later...")
        }
    }
}
