//
//  PlaylistItemVC.swift
//  Swift News
//
//  Created by Marc Aupont on 12/9/18.
//  Copyright © 2018 Marc Aupont. All rights reserved.
//

import UIKit

class PlaylistItemVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var playlistItems = [PlaylistItem]()
	var filteredPlaylistItems = [PlaylistItem]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 359
		tableView.delegate = self
		tableView.dataSource = self
		
		// Setup the Search Controller
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Swift News"
		definesPresentationContext = true
		
		navigationController?.navigationBar.isTranslucent = false
		
		downloadVideoData()
	}
	
	func downloadVideoData() {
		
		let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PL8seg1JPkqgH-ZuXSBBXRGRlnmVtEud04&maxResults=50&key=AIzaSyBUDvatdRh5copJOd0-giwKHu2ARnpI0KM")!
		let request = URLRequest(url: url)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			guard let data = data else { return }
			
			let decoder = JSONDecoder()
			do {
				let response = try decoder.decode(ServerResponse.self, from: data)
				DispatchQueue.main.async {
					response.items.forEach({ item in
						self.playlistItems.append(item)
						self.filteredPlaylistItems.append(item)
					})
					self.tableView.reloadData()
				}
			} catch {
				print(error.localizedDescription)
			}
			
		}
		task.resume()
	}
}

extension PlaylistItemVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredPlaylistItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? PlaylistItemCell else {
			fatalError("Could not dequeue cell")
		}
		
		let playlistItem = filteredPlaylistItems[indexPath.row]
		
		cell.configureCell(from: playlistItem)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let playlistItemDetailVC = storyboard?.instantiateViewController(withIdentifier: "PlaylistItemDetailVC") as? PlaylistItemDetailVC else {
			return
		}
		playlistItemDetailVC.playlistItem = playlistItems[indexPath.row]
		navigationController?.pushViewController(playlistItemDetailVC, animated: true)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 359.0
	}
}

extension PlaylistItemVC: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		if let text = searchController.searchBar.text, text.count > 0 {
			filteredPlaylistItems = playlistItems.filter {
				$0.title.lowercased().contains(text.lowercased()) || $0.description.lowercased().contains(text.lowercased())
			}
		} else {
			filteredPlaylistItems = playlistItems
		}
		tableView.reloadData()
	}
}

