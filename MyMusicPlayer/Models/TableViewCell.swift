//
//  TableViewCell.swift
//  MyMusicPlayer
//
//  Created by Dipanwita Bardhan on 13/06/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var detailsSong: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var playPauseBtn : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
