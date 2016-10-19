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
        //requestServiceBtn.setRadiusConer()
        //contentLbl.setRadiusConer()
        ConstantHelper.roundButton(requestServiceBtn, color: ConstantHelper.defaultSessionTextColor)
        initScreen()
        initData()
        contentLbl.text = "Sep. 30 - 7:00pm - Public lynching" + "\n" + "Oct 1 - 8:30pm - Town Sq. Clearnup" + "\n"  + "Oct 2 - City Council Meeting" 

        /*
        MBProgressHUD.showAdded(to: self.newCollectionView, animated: true)
        ApiClient.sharedInstance.getNews { ( news) in
            if news != nil {
                self.news  = news
                self.newCollectionView.reloadData()
            }
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.newCollectionView, animated: true)
            }
        }
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initScreen(){
        self.navigationItem.title = "DNA"
        viewRequestService.backgroundColor = ConstantHelper.redColor
        addDefaultNavUI()
    }
    
    func initData(){
        let imgUrl = "http://www.saintlouisdna.org/wp-content/uploads/2016/08/Untitled-design.png"
        let news1 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let news2 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let news3 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let news4 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let news5 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
        let news6 = News(imageUrl: imgUrl, title: "Downtown Street Alert", content: "Downtown streets will be impacted this weekend by the Sista Strut Breast Cancer Walk (10/1).  See the street closure information below.  Plan ahead for an alternative route or added travel time.")
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCellID", for: indexPath) as! NewCollectionViewCell
        let new = news[indexPath.row]
        cell.titleLbl.text = new.title
        cell.contentLbl.text = new.content
        cell.organizationLbl.text = "Cas Group"
        if indexPath.row > 2 {
            cell.newImgView.downloadedFrom(link: new.imageUrl!)    
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToNewDetail", sender: nil)
    }
}
