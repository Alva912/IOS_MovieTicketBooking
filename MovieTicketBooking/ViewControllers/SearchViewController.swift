//
//  SearchViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var query: String?
    var movies: [MovieResult]?
    var movieSelected: MovieResult?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            findMovies(query)
            self.tableView.reloadData()
            print("####\n Search enter")
        } else {
            print("Error: No search input")
            return
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            findMovies(query)
            self.tableView.reloadData()
        } else {
            print("Error: No search input")
            return
        }
    }

    func findMovies(_ query: String) {

        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&api_key=\(ApiKey)") else {
            return
        }

        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")

                let movieRoot: MovieRootClass = MovieRootClass(fromJson: json)
                self.movies = movieRoot.results
                self.tableView.reloadData()
//                print("#######\n\(self.movies[1].title)")
            case .failure(let error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movies = self.movies {
            movieSelected = movies[indexPath.row]
            performSegue(withIdentifier: "selectSearchedSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellSearched", for: indexPath) as! MovieCellSelected
        if let movies = self.movies {
            let movie = movies[indexPath.row]
            let baseURL = "http://image.tmdb.org/t/p/w500"
            let imageURL = URL(string: baseURL + movie.posterPath)!

            cell.posterImageView.setImageWith(imageURL)
            cell.titleLabel.text = movie.title
            cell.dateLabel.text = "\(movie.releaseDate!)"
            cell.voteAvgLabel.text = "\(movie.voteAverage!)"
            cell.overviewLabel.text = movie.overview
        }

        return cell

    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "selectSearchedSegue":
                if let vc = segue.destination as? MovieInfoViewController {
                    vc.movie = movieSelected
                } else {
                    print("Error: Type cast failed for segue", identifier)
                }
                break
            default:
                print("Error: Prepare segue for unhandled identifier", identifier)
            }
        } else {
            print("Error: Segue with empty identifier is performed. Better check it.")
        }
    }

}
