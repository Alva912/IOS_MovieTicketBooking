//
//  MoviesViewController.swift
//  MovieTicketBooking
//
//  Created by yupei leng on 6/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import SwiftyJSON
import DropDown

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var movies: [MovieResult] = []
    var movieSelected: MovieResult?
    let menu: DropDown = {
        DropDown.appearance().contentMode = .center
        DropDown.appearance().selectionBackgroundColor = UIColor(named: "DarkRed")!
        DropDown.appearance().selectedTextColor = .white
        let menu = DropDown()
        menu.dataSource = [
            " Now Playing Movies",
            " Top Rated Movies",
            " Upcoming Movies",
            " Popular Movies",
            " Popular TV Shows",
            " Top Rated TV Shows",
            " On the Air TV Shows",
            " Airing Today TV Shows"
        ]
        menu.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        menu.customCellConfiguration = { index, title, cell in
            guard let cell = cell as? MenuCell else { return }
            cell.optionLabel.contentMode = .scaleAspectFill
        }
        return menu
    }()
    let routes: [String] = [
        "/movie/now_playing",
        "/movie/top_rated",
        "/movie/upcoming",
        "/movie/popular",
        "/tv/popular",
        "/tv/top_rated",
        "/tv/on_the_air",
        "/tv/airing_today"
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        fetchMovies("/movie/now_playing")
        self.menuButton.setTitle(" Now Playing Movies", for: .normal)
        
        // Set up drop down
        guard let topView = navigationController?.navigationBar.topItem?.titleView else { return }
        menu.anchorView = topView
        menu.direction = .bottom
        menu.width = topView.frame.width * 0.6
        menu.bottomOffset = CGPoint(x: (menu.anchorView?.plainView.bounds.width)! * 0.2, y:(menu.anchorView?.plainView.bounds.height)!)
        menu.dismissMode = .onTap
        menu.cellConfiguration = { [weak self] (index, item) in
            return "🎞  \(item)"
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        topView.addGestureRecognizer(gesture)
        
        // Select actions
        menu.selectionAction = { index, title in
            // print("index: \(index)\ntitle:\(title)")
            self.fetchMovies(self.routes[index])
            self.menuButton.setTitle(title, for: .normal)
        }
    }
    
    @objc func didTapTopItem() {
        menu.show()
    }
    
    func fetchMovies(_ route: String) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3\(route)?api_key=\(ApiKey)") else {
            return
        }
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let movieRoot: MovieRootClass = MovieRootClass(fromJson: json)
                self.movies = movieRoot.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        let imageURL = URL(string: ImgUrlKey + movie.posterPath)!
        
        cell.posterImageView.setImageWith(imageURL) // AFNetworking is better than Alamofire when comes to load images to UIImageView
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = "\(movie.releaseDate!)"
        var blackStars = ""
        var whiteStars = ""
        let starsNum = floorf(movie.voteAverage/2)
        for _ in 0..<Int(starsNum) {
            blackStars += "★"
        }
        for _ in 0..<Int(5-starsNum) {
            whiteStars += "☆"
        }
        cell.voteAvgLabel.text = blackStars + whiteStars + " " + String(format: "%.1f", movie.voteAverage)
        cell.overviewLabel.text = movie.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "selectMovieSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "selectMovieSegue":
                if let vc = segue.destination as? MovieInfoViewController {
                    vc.movie = movieSelected
                } else {
                    print("\nError: Type cast failed for segue", identifier)
                }
                break
            default:
                print("\nError: Prepare segue for unhandled identifier", identifier)
            }
        } else {
            print("\nError: Segue with empty identifier is performed. Better check it.")
        }
    }
}
