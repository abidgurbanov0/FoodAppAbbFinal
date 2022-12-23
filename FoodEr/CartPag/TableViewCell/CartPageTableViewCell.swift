//
//  CartPageTableViewCell.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import UIKit

class CartPageTableViewCell: UITableViewCell {
    @IBOutlet weak var labelAdet: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageFood: UIImageView!
    
    var delegate:CartPlusOrMinus?
    var indexPath : IndexPath?
    
    
    @IBAction func buttonMinus(_ sender: UIButton) {
        sender.preventRepeatedPresses()
        delegate?.cartMinus(indexPath: indexPath!)
    }
    
    @IBAction func buttonPlus(_ sender: UIButton) {
        sender.preventRepeatedPresses()
        delegate?.cartPlus(indexPath: indexPath!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
