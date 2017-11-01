//
//  UITableViewController.swift
//  hi
//
//  Created by labuser on 10/21/17.
//  Copyright © 2017 labuser. All rights reserved.
//
import Foundation
import UIKit


class ReviewsView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var reviewsTable: UITableView!
    let sharedSingleton = Singleton.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        reviewsTable.dataSource = self
        reviewsTable.delegate = self
        reviewsTable.register(UITableViewCell.self, forCellReuseIdentifier: "theTableCell")
        self.definesPresentationContext = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("in reviews \(sharedSingleton.reviews.description)")
        reviewsTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedSingleton.reviews.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = reviewsTable.dequeueReusableCell(withIdentifier: "reviewCell")! as UITableViewCell
        var reviewsList = sharedSingleton.reviews
        //print(indexPath.row)
        if (reviewsList.count > 0){
            cell.textLabel?.text = "\(reviewsList[indexPath.row].myReview)"
            cell.imageView?.image = reviewsList[indexPath.row].movieImage
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieVC = MovieView()
        var reviewsList = sharedSingleton.reviews
        movieVC.movieObject = reviewsList[indexPath.row]
        
        navigationController?.pushViewController(movieVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            sharedSingleton.reviews.remove(at: indexPath.row)
            reviewsTable.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

