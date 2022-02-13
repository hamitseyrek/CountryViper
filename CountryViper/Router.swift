//
//  Router.swift
//  CountryViper
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation

protocol CountryRouter {
    static func startExecution() -> CountryRouter
}

class CountryClassRouter : CountryRouter {
    static func startExecution() -> CountryRouter {
        let router = CountryClassRouter()
        return router
    }
    
    
}
