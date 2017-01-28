//
//  Created by Pawel Scibek on 24/09/16.
//  Copyright © 2016 Pawel Scibek. All rights reserved.
//

import UIKit

class SelectSoundCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func markAsCurrent(_ mark: Bool) {
        accessoryType = mark ? .checkmark : .none
    }
}
