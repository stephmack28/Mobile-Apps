//
//  UITableViewController.swift
//  hi
//
//  Created by labuser on 10/21/17.
//  Copyright © 2017 labuser. All rights reserved.
//
import Foundation
import UIKit


class FavoritesView: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var favoritesTable: UITableView!
    let sharedSingleton = Singleton.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //collectionView.delegate = self
        //collectionView.dataSource = self
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        favoritesTable.register(UITableViewCell.self, forCellReuseIdentifier: "theTableCell")
        self.definesPresentationContext = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("in favs \(sharedSingleton.favoritesMovieArray.description)")
        favoritesTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedSingleton.favoritesMovieArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favoriteMovie")! as UITableViewCell
        var favoritesList = sharedSingleton.favoritesMovieArray
        //print(indexPath.row)
        if (favoritesList.count > 0){
            cell.textLabel?.text = favoritesList[indexPath.row].movieName
            cell.imageView?.image = favoritesList[indexPath.row].movieImage
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieVC = MovieView()
        var favoritesList = sharedSingleton.favoritesMovieArray
        movieVC.movieObject = favoritesList[indexPath.row]
        
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            sharedSingleton.favoritesMovieArray.remove(at: indexPath.row)
            favoritesTable.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

