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
    var image: UIImage
    
    init(named: String, identify: String, school: String, description: String, aged: String, imaged: UIImage) {
        self.name = named
        self.id = identify
        self.university = school
        self.descript = description
        self.age = aged
        self.image = imaged
    }
    
    class func createStudent() -> [StudentModel]{
        var students = [StudentModel]()
        
        students.append(StudentModel(named: "Bill Gates", identify: "012", school: "Harvard", description: "Billionaire", aged: "62", imaged: #imageLiteral(resourceName: "billgates")))
        students.append(StudentModel(named: "Mark Zuckerberg", identify: "345", school: "Harvard", description: "Billionaire", aged: "32", imaged: #imageLiteral(resourceName: "mark")))
        students.append(StudentModel(named: "Warren Buffett", identify: "456", school: "Columbia", description: "Billionaire", aged: "86", imaged: #imageLiteral(resourceName: "warrent")))
        
        return students
    }
}

