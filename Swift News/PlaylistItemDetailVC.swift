//
//  PlaylistItemDetailVC.swift
//  Swift News
//
//  Created by Marc Aupont on 1/31/19.
//  Copyright © 2019 Marc Aupont. All rights reserved.
//

import UIKit
import YouTubePlayer
import SafariServices

class PlaylistItemDetailVC: UIViewController {
	
	@IBOutlet private weak var playerView: YouTubePlayerView!
	@IBOutlet weak var textView: UITextView!
	
	var playlistItem: PlaylistItem!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		textView.delegate = self
		playerView.delegate = self
		playerView.loadVideoID(playlistItem.videoId)
		textView.text = playlistItem.description
    }

}

// MARK: - YouTubePlayerDelegate
extension PlaylistItemDetailVC: YouTubePlayerDelegate {
	
	func playerReady(_ videoPlayer: YouTubePlayerView) {
		
	}
}

// MARK: - UITextViewDelegate
extension PlaylistItemDetailVC: UITextViewDelegate {
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		let safariVC = SFSafariViewController(url: URL)
		present(safariVC, animated: true, completion: nil)
		return false
	}
}
