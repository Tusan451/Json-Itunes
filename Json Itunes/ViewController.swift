//
//  ViewController.swift
//  Json Itunes
//
//  Created by Olegio on 03.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()
    var searchResponce: SearchResponce? = nil

    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=5"
        
        networkService.request(urlString: urlString) { result in
            switch result {
            case .success(let searchResponce):
                self.searchResponce = searchResponce
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchResponce?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponce?.results[indexPath.row]
        
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

