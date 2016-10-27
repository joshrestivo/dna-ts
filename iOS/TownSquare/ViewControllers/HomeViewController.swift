//
//  ViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/4/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: BaseCenterViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var bulletinCollectionView: UICollectionView!
    @IBOutlet weak var newCollectionView: UICollectionView!
    @IBOutlet weak var viewRequestService: UIView!
    @IBOutlet weak var requestServiceBtn: UIButton!
    @IBOutlet weak var contentLbl: MarginLabel!
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConstantHelper.roundButton(requestServiceBtn, color: ConstantHelper.buttonBorderColor, radius: 5)
        initScreen()
        initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func requestService(_ sender: AnyObject) {
        self.navigateToView("sbNewsDetail")
    }
    
    func initScreen(){
        contentLbl.text = ConstantHelper.cache["home_middle_left_content"] as! String
        self.navigationItem.title = ConstantHelper.cache["home_header_title"] as! String
        requestServiceBtn.setTitle(ConstantHelper.cache["home_middle_request_button_text"] as! String, for: UIControlState.normal)
        viewRequestService.backgroundColor = ConstantHelper.redColor
        addDefaultNavUI()
    }
    
    func initData(){
        let imgUrl = "http://www.saintlouisdna.org/wp-content/uploads/2016/08/Untitled-design.png"
        let news1 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        let news2 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        let news3 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        let news4 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        let news5 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        let news6 = News(imageUrl: imgUrl, title: ConstantHelper.cache["menu_new_title"] as! String, content: ConstantHelper.cache["menu_new_content"] as! String)
        news.append(news1)
        news.append(news2)
        news.append(news3)
        news.append(news4)
        news.append(news5)
        news.append(news6)
        self.newCollectionView.reloadData()
        self.bulletinCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if self.news != nil {
            return self.news.count
        }
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize( width: self.view.bounds.width, height: newCollectionView.bounds.size.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCellID", for: indexPath) as! NewCollectionViewCell
        let new = news[indexPath.row]
        cell.titleLbl.text = new.title
        cell.contentLbl.text = new.content
        if collectionView == self.newCollectionView {
            cell.organizationLbl.text = "Cas Group - News"
        }
        else{
            cell.organizationLbl.text = "Cas Group - Buletin"
        }
        
        if indexPath.row > 2 {
            cell.newImgView.downloadedFrom(link: new.imageUrl!)    
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToNewDetail", sender: nil)
    }
}
