
//

import UIKit

class ToursTableViewCell: UITableViewCell {

    //OUTLETS
    
    @IBOutlet weak var tourDetail: UILabel!
    @IBOutlet weak var tourName: UILabel!
    
    // MARK: NIB LIFECYCLE FUNCTION
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
