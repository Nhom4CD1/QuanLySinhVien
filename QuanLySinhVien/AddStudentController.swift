//
//  AddStudentController.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class AddStudentController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtFTen: UITextField!
    @IBOutlet weak var txtFMaSV: UITextField!
    @IBOutlet weak var txtFTruong: UITextField!
    @IBOutlet weak var txtFTuoi: UITextField!
    @IBOutlet weak var txtViewChuThich: UITextView!
    @IBOutlet weak var imgThemSV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        // numberPad without "." button, decimalPad has "."
        /*txtFTuoi.keyboardType = UIKeyboardType.numberPad
         txtFMaSV.keyboardType = UIKeyboardType.numberPad*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Pick a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgThemSV.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChonAnhAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK :- User press button Save
    @IBAction func btnLuuAction(_ sender: UIBarButtonItem) {
        if txtFTen.text!.isEmpty || txtFMaSV.text!.isEmpty || txtFTruong.text!.isEmpty ||  txtViewChuThich.text!.isEmpty ||  txtViewChuThich.text!.isEmpty || imgThemSV.image == nil{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            
        }
        else {
            Constants.isLoadDataAgain = true
            let age = Int(txtFTuoi.text!)! // "!"unwraped optional
            let student: StudentModel = StudentModel(named: txtFTen.text!, identify: txtFMaSV.text!, school: txtFTruong.text!, description: txtViewChuThich.text!, aged: String(describing: age), imaged: imgThemSV.image!)
            Constants.student = student
            // Back To Management Student Screen
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // UITextFieldDelegate ( Keyboard will  disable when press return )
    // User must set delegate from this textfield to this view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtFTen.isEditing {
            txtFMaSV.becomeFirstResponder()
        } else if txtFTruong.isEditing {
            txtFTuoi.becomeFirstResponder()
        }
        return true
    }
    
    // UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        txtFTen.resignFirstResponder()
        txtFMaSV.resignFirstResponder()
        txtFTuoi.resignFirstResponder()
        txtFTruong.resignFirstResponder()
        txtViewChuThich.resignFirstResponder()
    }}
