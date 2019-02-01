//
//  PlaylistItemDetailVC.swift
//  Swift News
//
//  Created by Marc Aupont on 1/31/19.
//  Copyright © 2019 Marc Aupont. All rights reserved.
//

import UIKit

class PlaylistItemDetailVC: UIViewController {
	
	var playlistItem: PlaylistItem!

	@IBOutlet weak var textView: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		textView.text = playlistItem.description
		textView.contentInsetAdjustmentBehavior = .never
    }

}
