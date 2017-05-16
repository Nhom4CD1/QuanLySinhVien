//
//  MangementStudentModelController.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
//Chức năng search, tìm kiếm theo loại:
enum selectedScope:Int {
    case ten = 0
    case  mssv = 1
    case tuoi = 2
    case gioitinh = 3
    case truong = 4
}


class MangementStudentController: UITableViewController, UISearchBarDelegate{
    //MARK: - Property
       let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
    
    //Lấy tất cả Sinh Viên
    lazy var students: [StudentModel] = {
        return StudentModel.createStudent()
    }()
    //Lấy initial students cho việc Tìm kiếm
    lazy var initialStudentModel: [StudentModel] = {
        return StudentModel.createStudent()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.searchBarSetup()
    }
    
    func searchBarSetup() {
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Tên","MSSV","Tuổi","Giới Tính", "Trường"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
    }
    
    
    // MARK: - search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
        if searchText.isEmpty {
            students = initialStudentModel
            self.tableView.reloadData()
        }else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func filterTableView(ind:Int,text:String) {
        tableView.reloadData()
        switch ind {
        case selectedScope.ten.rawValue:
            //sửa lỗi not searching khi backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.name.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case selectedScope.mssv.rawValue:
            //sửa lỗi not searching khi backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.id.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case selectedScope.tuoi.rawValue:
            //sửa lỗi not searching khi backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.age.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.gioitinh.rawValue:
            //sửa lỗi not searching khi backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.gioitinh.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.truong.rawValue:
            //sửa lỗi not searching khi backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.university.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        default:
            print("No Type Found!!!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Màn hình chính
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Constants.isLoadDataAgain {
            let student: StudentModel = Constants.student
            students.append(student)
            initialStudentModel = students // reload lại khai báo initialStudentModel
            tableView.reloadData()
            Constants.isLoadDataAgain = false
        }
        else{
            tableView.reloadData()
            initialStudentModel = students // reload lại khai báo initialStudentModel
        }
        animateTable()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return students.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        
        // Configure the cell...
        
        let student = students[indexPath.row]
        
        cell.lblTen.text = student.name
        cell.lblMaSV.text = student.id
        cell.lblTruong.text = student.university
        cell.lblTuoi.text = student.age
        cell.lblGioiTinh.text = student.gioitinh
        cell.imgStudent.image = student.image
        
        return cell
    }
    
    //Hiện chi tiết
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "StudentDetail") {
            // initialize new view controller and cast it as your view controller
            let studentDetailVC = segue.destination as! StudentDetailController
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let student: StudentModel
                student = students[indexPath.row]
                studentDetailVC.studentModel = student
            }
            
        }
    }
    
    //MARK: - Xoá khi người dùng swipe to left
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            students.remove(at: indexPath.row)
            //Cạp nhật table view khi  data source thay đổi
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            initialStudentModel = students // reload lại khai báo initialStudentModel
        }
    }
    
    //MARK: - Sort khi người dùng click edit button
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Lấy data thông qua sourceIndexPath
        let currentStudentModel = students[sourceIndexPath.row];
        students.remove(at: sourceIndexPath.row)
        students.insert(currentStudentModel, at: destinationIndexPath.row)
        initialStudentModel = students // reload lại khai báo initialStudentModel
    }
    
    //MARK: - Animation cho TableView
    func animateTable() {
        
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 0.85, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    // UIScrollViewDelegate ( Keyboard sẽ ẩn khi scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
