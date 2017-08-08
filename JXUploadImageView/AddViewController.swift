//
//  AddViewController.swift
//  JXUploadImageView
//
//  Created by 杜进新 on 2017/8/2.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit
import TZImagePickerController

class AddViewController: UIViewController , TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var uploadImageView: JXUploadImageView!
    @IBOutlet weak var addButton: UIButton!
    
    var completion : ((Dictionary<String,Any>)->())?
    
    var imageDataArray = Array<Data>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addButton.layer.cornerRadius = 5
        self.uploadImageView.leftImageView.image = #imageLiteral(resourceName: "addPhoto")
        self.uploadImageView.style = .edit
        
        self.uploadImageView.selectImagesBlock = { index in
            
            let alert = UIAlertController(title: "图片选择", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "从相册中选择（最多三张）", style: .destructive, handler: { (alertAction) in
                self.selectAlbumImage()
            }))
            alert.addAction(UIAlertAction(title: "拍照", style: .destructive, handler: { (alertAction) in
                self.takePhotoImage()
            }))
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (alertAction) in
                //
            }))
            self.present(alert, animated: true, completion: { 
                //
            })
        }
        self.uploadImageView.deleteImagesBlock = { index in
            //
            self.imageDataArray.remove(at: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        guard let title = titleTextFiled.text,
            title.isEmpty == false else{
            print("请输入标题")
            return
        }
        guard let content = contentView.text,
            content.isEmpty == false else{
            print("请输入内容")
            return
        }
        
        if let completion = completion{
            var dict = Dictionary<String, Any>.init(minimumCapacity: 3)
            dict["title"] = title
            dict["content"] = content
            //图片应该是 本地图片数组（imageDataArray）上传到服务器之后获取到的图片在服务器的URL，demo不做图片上传的处理，使用假数据代替
            dict["image"] = "https://image.guangjiego.com/ShoppingGo/UserShow/4515_0/636376445577725335.jpg,https://image.guangjiego.com/userheader/334468c0d9934987b43007af93d48f2b.jpg,https://image.guangjiego.com/ShoppingGo/UserShow/11_0/636371930964713202.jpg,https://image.guangjiego.com/ShoppingGo/UserShow/11_0/636371010493130814.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/8/SysBg/ab1192472017080314011600.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/8/SysBg/43f531b22017080511562100.jpg,"
            completion(dict)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func selectAlbumImage() {
        
        var imageArray = self.uploadImageView.imageArray ?? Array<Any>()
        
        
        let imagePickerVC = TZImagePickerController.init(maxImagesCount: 3 - (self.uploadImageView.imageArray?.count)!, delegate: self)
        imagePickerVC?.allowTakePicture = false
        
        imagePickerVC?.allowPickingImage = true
        imagePickerVC?.allowPickingOriginalPhoto = true
        
        imagePickerVC?.sortAscendingByModificationDate = true
        
        imagePickerVC?.didFinishPickingPhotosHandle = { (images, assets, isSelectOriginalPhoto) -> () in
            
            if let images = images {
                images.forEach({ (image) in
                    imageArray.append(image)
                    //self.uploadImageView.imageArray?.append(images)
                })
                //self.uploadImageView.imageArray += images
                self.uploadImageView.imageArray = imageArray
                //self.setImages(images: self.uploadImageView.imageArray)
            }
            
            for asset in assets! {
                
                PHImageManager.default().requestImageData(for: asset as! PHAsset, options: nil, resultHandler: { (data, uti, orientation, dict) in
                    
                    guard let data = data else{
                        return
                    }
                    //成功后才加入。。。待完善    请求失败时与外部的image数组不同步
                    self.imageDataArray.append(data)
                    
                    if data.count > 10 * 1024 * 1024 {
                        print("图片大于10M")
                    }
                })
            }
        }
        self.present(imagePickerVC!, animated: true, completion: nil)
    }
    func takePhotoImage() {
        let vc = UIImagePickerController.init()
        vc.delegate = self
        vc.sourceType = .camera
        self.present(vc, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newImage = UIImage.image(originalImage: image, to: UIScreen.main.bounds.width)
        
        if let im = newImage {
            self.uploadImageView.imageArray?.append(im)
            
            if let data = UIImageJPEGRepresentation(im, 0.01){
                self.imageDataArray.append(data)
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddViewController : UITextViewDelegate,UITextFieldDelegate{
    //MARK:UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count > 12 {
            print("标题长度最长为12个字符")
            return false
        }
        return true
    }
    //MARK:UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.characters.count > 100 {
            print("内容长度最长为100个字符")
            return false
        }
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}












