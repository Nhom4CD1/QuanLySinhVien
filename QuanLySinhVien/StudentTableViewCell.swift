//
//  StudentTableViewCell.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTen: UILabel!
    @IBOutlet weak var lblMaSV: UILabel!
    @IBOutlet weak var lblTruong: UILabel!
    @IBOutlet weak var lblTuoi: UILabel!
    //lblGioiTinh
    @IBOutlet weak var lblGioiTinh: UILabel!
    @IBOutlet weak var imgStudent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
