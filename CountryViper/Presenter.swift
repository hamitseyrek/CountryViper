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
    
    var interactor: CountryInteractor?
    
    var view: CountryView?
    
    func interactorDidDownloadCountry(result: Result<[Country], Error>) {
        switch result {
        case .success(let countries):
            //view update
            print(countries)
        case .failure(let error):
            //show error
            print(error)
        default:
            //default
            print("default")
        }
    }
}
