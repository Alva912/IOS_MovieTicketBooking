//
//  MoviesViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
//    var movies: [Movie] = [];
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        fetchMovies()
    }

    func fetchMovies() {
        let apiKey = "1d9dc9496ed70743df22e49cabadb2b6"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDict = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//                    if let moviesRaw = responseDict["results"] as? [NSDictionary] {
//                        var movies: [Movie] = []
//                        for movie in moviesRaw {
//                            movies.append(
//                                Movie(
//                                    title: movie["title"] as! String,
//                                    date: movie["release_date"] as! String,
//                                    voteAverage: movie["vote_average"] as! Double,
//                                    overview: movie["overview"] as! String,
//                                    posterPath: movie["poster_path"] as! String))
//                        }
                        self.movies = responseDict["results"] as! [NSDictionary]
                        self.tableView.reloadData()
//                    }
                }
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movieRaw = movies![indexPath.row]
        let movie = Movie(
            title: movieRaw["title"] as! String,
            date: movieRaw["release_date"] as! String,
            voteAverage: movieRaw["vote_average"] as! Double,
            overview: movieRaw["overview"] as! String,
            posterPath: movieRaw["poster_path"] as! String
        )
        
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let imageURL = NSURL(string: baseURL + movie.posterPath)

        cell.posterImageView.setImageWith(imageURL! as URL)
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "\(movie.date)"
        cell.voteAvgLabel.text = "\(movie.voteAverage)"
        cell.overviewLabel.text = movie.overview

        return cell
    }

}
