//
//  Models.swift
//  Swift News
//
//  Created by Marc Aupont on 12/9/18.
//  Copyright © 2018 Marc Aupont. All rights reserved.
//

import Foundation

struct ServerResponse: Decodable {
	var items: [PlaylistItem]
}

struct PlaylistItem: Decodable {
	var id: String
	var title: String
	var description: String
	var imageUrl: URL
	var publishedDate: String
	
	private enum ItemCodingKeys: String, CodingKey {
		case id
		case snippet
		case resourceId
	}
	
	private enum SnippetCodingKeys: String, CodingKey {
		case title
		case description
		case thumbnails
		case publishedDate = "publishedAt"
	}
	
	private enum ThumbNailsCodingKeys: String, CodingKey {
		case standard
	}
	
	private enum StandardCodingKeys: String, CodingKey {
		case imageUrl = "url"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: ItemCodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		let snippetContainer = try container.nestedContainer(keyedBy: SnippetCodingKeys.self, forKey: .snippet)
		title = try snippetContainer.decode(String.self, forKey: .title)
		description = try snippetContainer.decode(String.self, forKey: .description)
		publishedDate = try snippetContainer.decode(String.self, forKey: .publishedDate)
		let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: ThumbNailsCodingKeys.self, forKey: .thumbnails)
		let standardContainer = try thumbnailsContainer.nestedContainer(keyedBy: StandardCodingKeys.self, forKey: .standard)
		imageUrl = try standardContainer.decode(URL.self, forKey: .imageUrl)
	}
}

