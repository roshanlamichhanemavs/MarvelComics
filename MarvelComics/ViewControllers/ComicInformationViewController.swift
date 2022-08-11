//
//  ComicInformationViewController.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/10/22.
//

import UIKit
import Nuke

class ComicInformationViewController: UIViewController {
    
    let tableCellIdentifier = "comicCell"
    let padding = 8.0
    
    @IBOutlet weak private var comicImageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    
    public var marvelComics: MarvelCharacter?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    public func configure(with marvelComics: MarvelCharacter) {
        self.marvelComics = marvelComics
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionLabel.text = marvelComics?.characterDescription
        guard let url = marvelComics?.imageURLPathWithExtension else {
            return
        }
        Nuke.loadImage(with: url, into: comicImageView)
    }
    
}


extension ComicInformationViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelComics?.comics?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath)
        cell.textLabel?.text = marvelComics?.comics?[indexPath.row].name
        return cell
    }
    
}
