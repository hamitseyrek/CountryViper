//
//  Router.swift
//  CountryViper
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController & CountryView

protocol CountryRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> CountryRouter
}

class CountryClassRouter : CountryRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> CountryRouter {
        
        let router = CountryClassRouter()
        
        var view : CountryView = CountryViewcontroller()
        var presenter : CountryPresenter = CountryClassPresenter()
        var interactor : CountryInteractor = CountryClassInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}
