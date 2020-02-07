//
//  MovieHomeViewController.swift
//  LenskartIMDB
//
//  Created by Tarang Kaneriya on 13/01/20.
//  Copyright © 2020 Tarang Kaneriya. All rights reserved.
//

import UIKit

class MovieHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var movieHomeViewModel = MovieHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
           movieHomeViewModel.requestData()
    }

       // MARK: - Bindings

       private func setupBindings() {

           // Binding loading to Viewcontroller
           movieHomeViewModel.isLoading = { [weak self] (isLoading) in
               guard let strongSelf = self else { return }
               isLoading ? strongSelf.startAnimating() : strongSelf.stopAnimating()
           }

           // Observing errors to show
           movieHomeViewModel.onError = { (error) in
               switch error {
               case .internetError(let message):
                   MessageView.sharedInstance.showOnView(message: message, theme: .error)
               case .serverMessage(let message):
                   MessageView.sharedInstance.showOnView(message: message, theme: .warning)
               }
           }

           // Observing Updates from ViewModel
           movieHomeViewModel.didUpdate = { [weak self] _ in
               guard let strongSelf = self else { return }
               strongSelf.tableView.reloadData()
           }

       }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MovieHomeViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieHomeViewModel.movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.defaultIdentifier, for: indexPath) as! MovieCell

        cell.movieData = movieHomeViewModel.movieList[indexPath.row]

        return cell

    }

}
