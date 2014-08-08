//
//  CommentTableViewCell.swift
//  Hackathon2
//
//  Created by Paul Schmidt on 8/7/14.
//  Copyright (c) 2014 Paul Schmidt. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timelineLabel: UILabel!
    
    init (style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier : reuseIdentifier)
    }
    
    override func awakeFromNib()  {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)  {
        super.setSelected(selected, animated: animated)
    }
}
