//
//  PlaylistItemDetailVC.swift
//  Swift News
//
//  Created by Marc Aupont on 1/31/19.
//  Copyright © 2019 Marc Aupont. All rights reserved.
//

import UIKit
import YouTubePlayer

class PlaylistItemDetailVC: UIViewController {
	
	@IBOutlet private weak var playerView: YouTubePlayerView!
	@IBOutlet weak var textView: UITextView!
	
	var playlistItem: PlaylistItem!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		playerView.delegate = self
		playerView.loadVideoID(playlistItem.videoId)
		textView.text = playlistItem.description
    }

}

extension PlaylistItemDetailVC: YouTubePlayerDelegate {
	
	func playerReady(_ videoPlayer: YouTubePlayerView) {
		
	}
}
