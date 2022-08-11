//
//  ViewController.swift
//  MarvelComics
//
//  Created by Roshan Lamichhane on 8/9/22.
//

import UIKit

class ViewController: UIViewController {

    let tableCellIdentifier = "cell"
    let identifier = "ComicInformationViewController"
    let storyboardIdentifier = "Main"
    let tableViewAccessibilityIdentifier = "charactersTable"
    
    @IBOutlet weak var tableView: UITableView!
    private var marvelCharacters: [MarvelCharacter] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.accessibilityIdentifier = tableViewAccessibilityIdentifier
        tableView.isAccessibilityElement = true
        
        let viewModel = MarvelCharactersViewModel(environment: Environment(), endPoint: .character)
        viewModel.fetchMarvelCharacters { [weak self ]information in
            self?.marvelCharacters = information
            self?.tableView.reloadData()
        }
      
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: storyboardIdentifier, bundle: .main)
        guard let comicsTableViewController  = storyBoard.instantiateViewController(withIdentifier: identifier) as? ComicInformationViewController else { return }
        comicsTableViewController.configure(with: marvelCharacters[indexPath.row])
        navigationController?.pushViewController(comicsTableViewController, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier)
        cell?.textLabel?.text = String(marvelCharacters[indexPath.row].characterIdentifer)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marvelCharacters.count
    }
    
}
