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
	let id: String
	let title: String
	let description: String
	let imageUrl: URL
	let publishedDate: String
	let videoId: String
	
	private enum ItemCodingKeys: String, CodingKey {
		case id
		case snippet
	}
	
	private enum SnippetCodingKeys: String, CodingKey {
		case title
		case description
		case thumbnails
		case publishedDate = "publishedAt"
		case resourceId
	}
	
	private enum ThumbNailsCodingKeys: String, CodingKey {
		case standard
	}
	
	private enum StandardCodingKeys: String, CodingKey {
		case imageUrl = "url"
	}
	
	private enum ResourceIdCodingKeys: String, CodingKey {
		case videoId
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
		let resourceContainer = try snippetContainer.nestedContainer(keyedBy: ResourceIdCodingKeys.self, forKey: .resourceId)
		videoId = try resourceContainer.decode(String.self, forKey: .videoId)
	}
	
	func sanitizedTitle() -> String? {
		let splitTitle = title.split(separator: "-")
		let secondString = String(splitTitle[1].trimmingCharacters(in: .whitespaces))
		return secondString
	}
	
}

extension String {
	func timeAgoDisplay() -> String {
		
		let f:DateFormatter = DateFormatter()
		
		f.timeZone = NSTimeZone.local
		
		f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		let now = f.string(from: NSDate() as Date)
		
		let startDate = f.date(from: self)
		
		let endDate = f.date(from: now)
		
		let calendar: NSCalendar = NSCalendar.current as NSCalendar
		
		let calendarUnits = NSCalendar.Unit.weekOfMonth.union( NSCalendar.Unit.day).union(NSCalendar.Unit.hour).union(NSCalendar.Unit.minute).union(NSCalendar.Unit.second).union(NSCalendar.Unit.month).union(NSCalendar.Unit.year)
		
		let dateComponents = calendar.components(calendarUnits, from: startDate!, to: endDate!, options: [])
		
		let weeks = abs(Int32(dateComponents.weekOfMonth!))
		let days = abs(Int32(dateComponents.day!))
		let hours = abs(Int32(dateComponents.hour!))
		let min = abs(Int32(dateComponents.minute!))
		let sec = abs(Int32(dateComponents.second!))
		let months = abs(Int32(dateComponents.month!))
		let years = abs(Int32(dateComponents.year!))
		
		var timeAgo = ""
		if sec > 0 {
			if (sec > 1) {
				timeAgo = "\(sec) Seconds Ago"
				
			} else {
				timeAgo = "\(sec) Second Ago"
			}
			
		}
		if min > 0 {
			if (min > 1) {
				timeAgo = "\(min) Minutes Ago"
			} else {
				timeAgo = "\(min) Minute Ago"
			}
		}
		
		if hours > 0 {
			if (hours > 1) {
				timeAgo = "\(hours) Hours Ago"
			} else {
				timeAgo = "\(hours) Hour Ago"
			}
		}
		if days > 0 {
			if (days > 1) {
				timeAgo = "\(days) Days Ago"
			} else {
				timeAgo = "\(days) Day Ago"
			}
		}
		
		if weeks > 0 {
			if (weeks > 1) {
				timeAgo = "\(weeks) Weeks Ago"
			} else {
				timeAgo = "\(weeks) Week Ago"
			}
		}
		
		if months > 0 {
			if (months > 1) {
				timeAgo = "\(months) months Ago"
			} else {
				timeAgo = "\(months) month Ago"
			}
		}
		
		if years > 0 {
			if (years > 1) {
				timeAgo = "\(years) years Ago"
			} else {
				timeAgo = "\(years) year Ago"
			}
			
		}
		
		return timeAgo;
		
	}
}

