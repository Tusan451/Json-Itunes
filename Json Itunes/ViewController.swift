//
//  ViewController.swift
//  Json Itunes
//
//  Created by Olegio on 03.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"
        request(urlString: urlString) { result in
            switch result {
            case .success(let searchResponce):
                searchResponce.results.map { track in
                    print(track.trackName)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func request(urlString: String, completion: @escaping (Result<SearchResponce, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let tracks = try JSONDecoder().decode(SearchResponce.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    print("Failed to decode Json", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "123"
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

