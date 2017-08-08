//
//  ListViewController.swift
//  JXUploadImageView
//
//  Created by 杜进新 on 2017/8/1.
//  Copyright © 2017年 dujinxin. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var dataArray = Array<ListModel>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = UIView()
        self.tableView.sectionFooterHeight = 0.1
        self.tableView.register(UINib.init(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
        
        handleData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if let vc = segue.destination as? AddViewController,
            identifier == "add" {
            vc.completion = {dict in
                let model = ListModel()
                model.setValuesForKeys(dict)
                self.dataArray.append(model)
                self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ListViewCell

        // Configure the cell...
        
        cell.model = dataArray[indexPath.row]
        
        cell.uploadImageView.clickImageBlock = {index,imageArray in
            let vc = JXPhotoBrowserController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.currentPage = index
            vc.images = imageArray as! Array<String>
            self.navigationController?.present(vc, animated: true, completion: nil)
        }

        return cell
    }

    func handleData() {
        let array = [
            [
                "title":"自律给我自由",
                "content":"[爱心][爱心]羊毛百褶裙，冬日搭配利器，您大腿穿毛裤棉裤羽绒裤也没人知道，毛衣短款长款如图任意搭配，衬衫塞裙子里没毛病！！以上穿法全攻略[坏笑][坏笑][爱心][爱心][爱心]",
                "image":"https://image.guangjiego.com/userheader/8b3df033a5d541bc83ad2dd79692f323.jpg"
            ],
            [
                "title":"TASOS（三里屯店）",
                "content":"",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d97aee552017011110102000.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d97aee552017011110102010.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d97aee552017011110102020.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d97aee552017011110102030.jpg"
            ],
            [
                "title":"长祯国术馆",
                "content":"冬练三九，张三基本功夫之撞肩，想要练好功夫，基本功很重要！",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/82b666a0201701111017400.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/82b666a0201701111017401.png"
            ],
            [
                "title":"迪信通",
                "content":"年底大回馈，购机送好礼！更有多种优惠套餐选择！",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/00a701d5201701111121260.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/00a701d5201701111121261.png"
            ],
            [
                "title":"小锅当家浓汁鸡煲饭（矿大店",
                "content":"所有菜品，来店消费减五元。",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/1f4c6386201701111130400.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/1f4c6386201701111130401.jpg"
            ],
            [
                "title":"毛绒玩具礼品店",
                "content":"新品：进口丹麦哥本哈根水貂毛兔子🐰挂饰。整张皮做的，手感超级柔软",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582700.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582710.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582720.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582730.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582740.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582750.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582760.png,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/d75418692017011113582770.png"
            ],
            [
                "title":"鑫百万巴依老爷",
                "content":"👏👏👏好消息好消息  毛衣特价160啦  喜欢的宝宝们千万不要错过机会呦  数量有限  绝对的爆款你值得拥有😃😃😃",
                "image":"https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/9105e7fc2017011118331600.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/9105e7fc2017011118331610.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/9105e7fc2017011118331620.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/9105e7fc2017011118331630.jpg,https://image.guangjiego.com/ShoppingGo/GJG/2017/1/SysBg/9105e7fc2017011118331640.jpg"
            ]
            
        ]
        
        
        for dict in array {
            let model = ListModel()
            model.setValuesForKeys(dict)
            self.dataArray.append(model)
        }
        
    }

}
