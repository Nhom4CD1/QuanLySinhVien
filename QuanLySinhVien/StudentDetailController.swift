//
//  StudentDetailController.swift
//  QuanLySinhVien
//
//  Created by THANH on 5/9/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class StudentDetailController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var studentModel: StudentModel!
    
    @IBOutlet weak var txtFTen: UITextField!
    @IBOutlet weak var txtFMaSV: UITextField!
    @IBOutlet weak var txtFTruong: UITextField!
    @IBOutlet weak var txtFTuoi: UITextField!
    @IBOutlet weak var txtViewChuThich: UITextView!
    @IBOutlet weak var imgAnhDaiDien: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // numberPad without "." button, decimalPad has "."
        /*textFieldAge.keyboardType = UIKeyboardType.numberPad
         textFieldID.keyboardType = UIKeyboardType.numberPad*/
        txtFTen.text = studentModel.name
        txtFMaSV.text = studentModel.id
        txtFTuoi.text = studentModel.age
        txtFTruong.text = studentModel.university
        txtViewChuThich.text = studentModel.descript
        imgAnhDaiDien.image = studentModel.image
    }
    
    /*//MARK: Detail Screen Disappear
     override func viewWillDisappear(_ animated: Bool) {
     
     }*/
    
    // MARK: - Pick a picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imgAnhDaiDien.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK : - User press choose image
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
    
    // MARK: - User click button save
    
    @IBAction func btnLuuAction(_ sender: UIBarButtonItem) {
        if txtFTen.text!.isEmpty || txtFMaSV.text!.isEmpty || txtFTruong.text!.isEmpty ||  txtViewChuThich.text!.isEmpty ||  txtFTuoi.text!.isEmpty{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
        }
        else {
            studentModel.name = txtFTen.text!
            studentModel.id = txtFMaSV.text!
            studentModel.university = txtFTruong.text!
            studentModel.age = txtFTuoi.text!
            studentModel.descript = txtViewChuThich.text!
            studentModel.image = imgAnhDaiDien.image!
        }
        // Back To Management Student Screen
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate ( Keyboard will  disable when press return )
    // User must set delegate from this textfield to this view
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textFieldName.resignFirstResponder()
        /*textFieldID.resignFirstResponder()
         textFieldAge.resignFirstResponder()
         textFieldUni.resignFirstResponder()*/
        if txtFTen.isEditing {
            txtFTen.resignFirstResponder()
        } else if txtFTruong.isEditing {
            txtFTruong.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: - UIScrollViewDelegate ( Keyboard will disable when scroll the UIView )
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        txtFTen.resignFirstResponder()
        txtFMaSV.resignFirstResponder()
        txtFTuoi.resignFirstResponder()
        txtFTruong.resignFirstResponder()
        txtViewChuThich.resignFirstResponder()
    }
}

