//
//  ViewController.swift
//  Swift News
//
//  Created by Marc Aupont on 12/9/18.
//  Copyright © 2018 Marc Aupont. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var playlistItems = [PlaylistItem]()
	var filteredPlaylistItems = [PlaylistItem]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 260
		tableView.delegate = self
		tableView.dataSource = self
		
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		
		// Setup the Search Controller
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Swift News"
		definesPresentationContext = true
		
//		textView.dataDetectorTypes = [.link]
//		textView.isEditable = false
//		textView.isSelectable = true
		
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
					for item in response.items {
						self.playlistItems.append(item)
					}
					self.tableView.reloadData()
				}
			} catch {
				print(error.localizedDescription)
			}
			
			
//			do {
//				let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//				print(jsonData)
//			} catch {
//				print(error.localizedDescription)
//			}
			
		}
		task.resume()
	}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return playlistItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? PlaylistItemCell else {
			fatalError("Could not dequeue cell")
		}
		
		let playlistItem = playlistItems[indexPath.row]
		
		cell.configureCell(from: playlistItem)
		
		return cell
	}
	
//	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//		return 240
//	}
}

extension ViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		
	}
}

