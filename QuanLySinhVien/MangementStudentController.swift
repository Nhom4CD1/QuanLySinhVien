//
//  MangementStudentModelController.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

enum selectedScope:Int {
    case name = 0
    case id = 1
    case age = 2
    case university = 3
}


class MangementStudentController: UITableViewController, UISearchBarDelegate{
    //MARK: - Property
    //let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
    
    //get all students
    lazy var students: [StudentModel] = {
        return StudentModel.createStudent()
    }()
    //get initial students for search
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
        searchBar.scopeButtonTitles = ["Name","ID","Age","University"]
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
        case selectedScope.name.rawValue:
            //fix of not searching when backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.name.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case selectedScope.id.rawValue:
            //fix of not searching when backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.id.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case selectedScope.age.rawValue:
            //fix of not searching when backspacing
            students = initialStudentModel.filter({ (stu) -> Bool in
                return stu.age.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
            
        case selectedScope.university.rawValue:
            //fix of not searching when backspacing
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
    
    // MARK: - Home Screen Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Constants.isLoadDataAgain {
            let student: StudentModel = Constants.student
            students.append(student)
            initialStudentModel = students // reload initialStudentModel
            tableView.reloadData()
            Constants.isLoadDataAgain = false
        }
        else{
            tableView.reloadData()
            initialStudentModel = students // reload initialStudentModel
        }
        animateTable()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        cell.imgStudent.image = student.image
        
        return cell
    }
    
    //show detail
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
    
    //MARK: - Delete when user swipe to left
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete){
            students.remove(at: indexPath.row)
            //update table view with new data source
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            initialStudentModel = students // reload initialStudentModel
        }
    }
    
    //MARK: - Sort when user click edit button
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //get data in sourceIndexPath
        let currentStudentModel = students[sourceIndexPath.row];
        students.remove(at: sourceIndexPath.row)
        students.insert(currentStudentModel, at: destinationIndexPath.row)
        initialStudentModel = students // reload initialStudentModel
    }
    
    //MARK: - Animation for TableView
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
    
    // UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
