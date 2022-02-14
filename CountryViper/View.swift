//
//  View.swift
//  CountryViper
//
//  Created by Hamit Seyrek on 13.02.2022.
//

import Foundation
import UIKit

protocol CountryView {
    var presenter : CountryPresenter? {get set}
    
    func update(with countries : [Country])
    func update(with error : String)
}

class CountryViewcontroller : UIViewController, CountryView, UITableViewDelegate, UITableViewDataSource {
    var presenter: CountryPresenter?
    var countries = [Country]()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        view.backgroundColor = .blue.withAlphaComponent(0.3)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = countries[indexPath.row].name
        content.secondaryText = countries[indexPath.row].code
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        return cell
    }
    
    func update(with countries: [Country]) {
        DispatchQueue.main.async {
            self.countries = countries
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.countries = []
            self.tableView.isHidden = true
            self.messageLabel.isHidden = false
            self.messageLabel.text = error
        }
    }
}
