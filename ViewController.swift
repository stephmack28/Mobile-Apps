//
//  ViewController.swift
//  lab4att1
//
//  Created by McCormack on 10/11/17.
//  Copyright © 2017 McCormack. All rights reserved.
//

import UIKit

//creative: favorite/unfavorite within movie view(done), popular movies button(done) and popular initial load(done), colored name in main if favorite(done), add reviews in new tab(done)

/*
 * API Source: tMDB at https://www.themoviedb.org
 */

 

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
    
    
    //@IBOutlet weak var movieCell: UICollectionViewCell!
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    //@IBOutlet weak var favoritesTable: UITableView!
    var movieList: JSON = [] //use it to display current movie collection
    var movieDataList : [MovieData] = []
    var currView: [MovieData] = []
    var favoritesList : [MovieData] = []
    let sharedSingleton = Singleton.shared
    
    
    @IBOutlet weak var movieSearch: UISearchBar!

    @IBAction func popularButton(_ sender: UIButton) {
        loadPopular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.definesPresentationContext = true
        movieSearch.delegate=self
        
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.center=view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.loadPopular()
            activityIndicator.stopAnimating()
        })
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("in favs \(sharedSingleton.favoritesMovieArray.description)")
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func populateMovieData(jsonData: JSON) {
        
       
        
       // print("tempdir is \(tempDir)")
        
        let movieArray = (jsonData["results"].array)!
        print(movieArray)
        currView.removeAll()
        
        for movie in movieArray{
            
            let movieID = movie["id"].int!
            
            let movieExists = movieDataList.contains{ $0.id==movieID}
            
            if movieExists{
                let currMovie = movieDataList.first(where: {$0.id==movieID})
                currView.append(currMovie!)
                
            } else {
            
                let theTitle = movie["title"].string!
                let theRating = movie["vote_average"].double!
                let theDescription = movie["overview"].string!
                let theDate = movie["release_date"].string!
                var theImage: String
                if movie["poster_path"] != JSON.null{
                    theImage = movie["poster_path"].string!
                    
                //print("the saved image is \(theImage)")
                    let imageURL = URL(string: ("https://image.tmdb.org/t/p/w500"+theImage))
                    let imageData = try? Data(contentsOf: imageURL!)
                    
                    if imageData != nil{
                        
                        let fullImage = UIImage(data: imageData!)
                        
                        let newMovie = MovieData(id: movieID, movieName: theTitle, movieImage: fullImage!, movieRating: theRating, movieDesc: theDescription, movieDate: theDate, favorite: false, myReview: "")
                        print("the saved movie is \(theTitle)")
                        currView.append(newMovie)
                        movieDataList.append(newMovie)
                    }
                }
                else{
                    let newMovie = MovieData(id: movieID, movieName: theTitle, movieImage: #imageLiteral(resourceName: "noData"), movieRating: theRating, movieDesc: theDescription, movieDate: theDate, favorite: false, myReview: "")
                    print("the saved movie is \(theTitle)")
                    currView.append(newMovie)
                    movieDataList.append(newMovie)
                }
            }
            
        }
        
        self.collectionView.reloadData()
        
    }
    
    func loadPopular() {
        movieList = getJSON(path: "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=d1541d20a43446316ba788221fffa64a")
        populateMovieData(jsonData: movieList)
    }
    
    func searchBarSearchButtonClicked(_ movieSearch: UISearchBar){
        //movieSearch.becomeFirstResponder()
        //creative portion
        //print("search")
        if movieSearch.text == ""{
            loadPopular()
        }
        else{
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator.center=collectionView.center
            
            activityIndicator.backgroundColor=UIColor.white
            activityIndicator.startAnimating()
            collectionView.addSubview(activityIndicator)
            
            collectionView.bringSubview(toFront: activityIndicator)
            DispatchQueue.main.async {
                self.movieList = self.getJSON(path: "https://api.themoviedb.org/3/search/movie?api_key=d1541d20a43446316ba788221fffa64a&query="+movieSearch.text!)
                self.populateMovieData(jsonData: self.movieList)
                activityIndicator.stopAnimating()
                
            }
            
           
        }
        
        
    }
    
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //print(movieDataList[indexPath.row].movieName)
        //favoritesList.append(movieDataList[indexPath.section*3+indexPath.row])
        let movieVC = MovieView()
        movieVC.movieObject = currView[indexPath.row]
        
        navigationController?.pushViewController(movieVC, animated: true)
        
        
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return currView.count/4
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // movieList = getJSON(path: "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=d1541d20a43446316ba788221fffa64a")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath)
        
        cell.backgroundColor=UIColor.white
        
        cell.backgroundView=UIImageView(image: currView[indexPath.row].movieImage)
        
        let labelFrame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height/4)
        let labelView = UILabel(frame: labelFrame)
        if sharedSingleton.favoritesMovieArray.contains(where: {$0.id==currView[indexPath.row].id}){
            labelView.textColor=UIColor.orange
        }
        labelView.text = currView[indexPath.row].movieName
        labelView.backgroundColor=UIColor.white
        labelView.textAlignment = .center
        
        cell.contentView.addSubview(labelView)
      

        return cell
    }
    
    
    private func getJSON(path: String) -> JSON {
        guard let url = URL(string: path) else {return JSON.null}
        do {
            let data = try Data(contentsOf: url)
            return try JSON(data: data as Data)
        } catch {
            return JSON.null
        }
    }
    
    
    
    
}

