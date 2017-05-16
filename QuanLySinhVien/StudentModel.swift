//
//  StudentModel.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit

class StudentModel: NSObject {
    var name: String
    var id: String
    var university: String
    var descript: String
    var age: String
    var gioitinh: String
    var image: UIImage
    
    init(named: String, identify: String, school: String, description: String, aged: String, gioitinh: String,imaged: UIImage) {
        self.name = named
        self.id = identify
        self.university = school
        self.descript = description
        self.age = aged
        self.gioitinh = gioitinh
        self.image = imaged
    }
    
    class func createStudent() -> [StudentModel]{
        
        var students = [StudentModel]()
        
        students.append(StudentModel(named: "Như Quỳnh", identify: "013", school: "Ngoại Thương", description: "NTH", aged: "22", gioitinh: "Nu", imaged: #imageLiteral(resourceName: "svnu")))
        students.append(StudentModel(named: "Tường Vy", identify: "014", school: "Kinh Tế", description: "NTH", aged: "23", gioitinh: "Nữ",
                                     imaged: #imageLiteral(resourceName: "svnu2") ))
        students.append(StudentModel(named: "Văn Nam", identify: "456", school: "SPKT", description: "SPKT", aged: "26", gioitinh: "Nam", imaged: #imageLiteral(resourceName: "svnam1")))
        
        return students
    }
}

