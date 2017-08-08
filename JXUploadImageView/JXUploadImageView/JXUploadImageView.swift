//
//  JXUploadImageView.swift
//  JXUploadImageView
//
//  Created by 杜进新 on 2017/8/1.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit


private let leadingTrailingMargin : CGFloat = 20
private let topMargin : CGFloat = 20
private let spaceWidth : CGFloat = 20

enum Style {
    case normal
    case edit
}

class JXUploadImageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var leftImageView: UploadImageView = {
        let imageView = UploadImageView(frame: CGRect())
        imageView.tag = 0
        
        imageView.deleteButton.tag = imageView.tag
        imageView.deleteButton.addTarget(self, action: #selector(deleteButtonClick(button:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    lazy var centerImageView: UploadImageView = {
        let imageView = UploadImageView(frame: CGRect())
        imageView.tag = 1
        
        imageView.deleteButton.tag = imageView.tag
        imageView.deleteButton.addTarget(self, action: #selector(deleteButtonClick(button:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    lazy var rightImageView: UploadImageView = {
        let imageView = UploadImageView(frame: CGRect())
        imageView.tag = 2
        
        imageView.deleteButton.tag = imageView.tag
        imageView.deleteButton.addTarget(self, action: #selector(deleteButtonClick(button:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick(tap:)))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    var style: Style = .normal {
        didSet{
            if style == .normal {
                
            }else{
                self.leftImageView.isHidden = false
                self.leftImageView.image = UIImage(named: "addPhoto")
            }
        }
    }
    var imageArray: Array<Any>? = Array(){
        didSet{
            self.handleImageArray(array: imageArray)
        }
    }
    /// 选择图片闭包
    var selectImagesBlock : ((_ index:Int)->())?
    /// 删除图片闭包
    var deleteImagesBlock : ((_ index:Int)->())?
    /// 图片点击闭包
    var clickImageBlock: ((_ index:Int,_ imageArray:Array<Any>?)->())?
    
    
    convenience init() {
        self.init()
        addSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        //fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sideLength = (frame.width - (leadingTrailingMargin + spaceWidth) * 2) / 3
        
        //leftImageView
        addConstraint(NSLayoutConstraint(item: self.leftImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: leadingTrailingMargin))
        addConstraint(NSLayoutConstraint(item: self.leftImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: topMargin))
        addConstraint(NSLayoutConstraint(item: self.leftImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: sideLength))
        addConstraint(NSLayoutConstraint(item: self.leftImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: sideLength))
        
        
        //centerImageView
        addConstraint(NSLayoutConstraint(item: self.centerImageView, attribute: .leading, relatedBy: .equal, toItem: self.leftImageView, attribute: .trailing, multiplier: 1.0, constant: spaceWidth))
        addConstraint(NSLayoutConstraint(item: self.centerImageView, attribute: .top, relatedBy: .equal, toItem: self.leftImageView, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: self.centerImageView, attribute: .height, relatedBy: .equal, toItem: self.leftImageView, attribute: .height, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: self.centerImageView, attribute: .width, relatedBy: .equal, toItem: self.leftImageView, attribute: .width, multiplier: 1.0, constant: 0))
        
        
        //rightImageView
        addConstraint(NSLayoutConstraint(item: self.rightImageView, attribute: .leading, relatedBy: .equal, toItem: self.centerImageView, attribute: .trailing, multiplier: 1.0, constant: spaceWidth))
        addConstraint(NSLayoutConstraint(item: self.rightImageView, attribute: .top, relatedBy: .equal, toItem: self.leftImageView, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: self.rightImageView, attribute: .height, relatedBy: .equal, toItem: self.leftImageView, attribute: .height, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: self.rightImageView, attribute: .width, relatedBy: .equal, toItem: self.leftImageView, attribute: .width, multiplier: 1.0, constant: 0))
    }
    func addSubviews() {
        
        self.addSubview(self.leftImageView)
        self.addSubview(self.centerImageView)
        self.addSubview(self.rightImageView)
        
        self.subviews.forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func handleImageString(imageString:String?) {
        let array = imageString?.components(separatedBy: ",")
        self.imageArray = array
        //handleImageArray(array: array)
    }
    private func handleImageArray(array:Array<Any>?) {
        clearSubViews()
        guard
            let array = array
            else {
                
                return
        }
        
        if style == .normal {
            if array.isEmpty == true {
                return
            }
            leftImageView.setImageInfo(isHidden: false, style: style, image: array.first)
            switch array.count {
            case 1:
                ()
            case 2:
                centerImageView.setImageInfo(isHidden: false, style: style, image: array[1])
            default:
                centerImageView.setImageInfo(isHidden: false, style: style, image: array[1])
                rightImageView.setImageInfo(isHidden: false, style: style, image: array[2])
            }
        }else{
            switch array.count {
            case 0:
                leftImageView.setImageInfo(isHidden: false, style: style, image: nil)
            case 1:
                leftImageView.setImageInfo(isHidden: false, style: style, image: array.first)
                centerImageView.setImageInfo(isHidden: false, style: style, image: nil)
            case 2:
                leftImageView.setImageInfo(isHidden: false, style: style, image: array.first)
                centerImageView.setImageInfo(isHidden: false, style: style, image: array[1])
                rightImageView.setImageInfo(isHidden: false, style: style, image: nil)
            default:
                leftImageView.setImageInfo(isHidden: false, style: style, image: array.first)
                centerImageView.setImageInfo(isHidden: false, style: style, image: array[1])
                rightImageView.setImageInfo(isHidden: false, style: style, image: array[2])
            }
        }
    }
    private func clearSubViews(){
        self.subviews.forEach { (view) in
            if view is UIImageView{
                let v = view as! UIImageView
                v.image = nil
                v.isHidden = true
            }
        }
    }
    @objc private func tapClick(tap:UITapGestureRecognizer) {
        if style == .normal {
            if
                let clickImageBlock = clickImageBlock,
                let index = tap.view?.tag
            {
                clickImageBlock(index,imageArray)
            }
        }else{
            if
                let selectImagesBlock = selectImagesBlock,
                let index = tap.view?.tag
            {
                selectImagesBlock(index)
            }
        }
        
    }
    @objc private func deleteButtonClick(button:UIButton) {
        self.imageArray?.remove(at: button.tag)
        if
            let deleteImagesBlock = deleteImagesBlock
        {
            deleteImagesBlock(button.tag)
        }
    }
}

class UploadImageView : UIImageView {
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"popover_btn_close"), for: .normal)
        button.isHidden = true
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        isUserInteractionEnabled = true
        contentMode = .scaleToFill
        isHidden = true
        
        addSubview(self.deleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.deleteButton.frame = CGRect(x: frame.size.width - 30, y: 0, width: 30, height: 30)
    }
    
    func setImageInfo(isHidden:Bool,style:Style = .normal,image:Any?) {
        self.isHidden = isHidden
        
        ///有图片，并且只有在编辑状态下才显示删除按钮
        if let image = image{
            self.jx_setImage(obj: image)
            self.deleteButton.isHidden = (style == .normal)
            
        }else{
            self.jx_setImage(obj: "addPhoto")
            self.deleteButton.isHidden = true
        }
        
    }
}
