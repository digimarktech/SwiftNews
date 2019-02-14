//
//  PlaylistItemCell.swift
//  Swift News
//
//  Created by Marc Aupont on 1/31/19.
//  Copyright © 2019 Marc Aupont. All rights reserved.
//

import UIKit
import SDWebImage

class PlaylistItemCell: UITableViewCell {

	@IBOutlet weak var playlistItemImageView: UIImageView!
	@IBOutlet weak var playlistItemTitleLabel: UILabel!
	@IBOutlet weak var playlistItemDateLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configureCell(from item: PlaylistItem) {
		playlistItemImageView.sd_setImage(with: item.imageUrl, placeholderImage: nil, options: .highPriority)
		playlistItemTitleLabel.text = item.sanitizedTitle()
		playlistItemDateLabel.text = item.publishedDate.timeAgoDisplay()
	}
}
