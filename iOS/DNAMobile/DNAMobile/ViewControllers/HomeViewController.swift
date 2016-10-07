//
//  ViewController.swift
//  DNAMobile
//
//  Created by Cuc Nguyen on 10/4/16.
//  Copyright © 2016 Cas-group. All rights reserved.
//

import UIKit
import MBProgressHUD

class HomeViewController: BaseCenterViewController {

    @IBOutlet weak var newCollectionView: UICollectionView!
    
    @IBOutlet weak var requestServiceBtn: UIButton!
    @IBOutlet weak var contentLbl: UILabel!
    
    
    var news:[New]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home view controller"
        requestServiceBtn.setRadiusConer()
        contentLbl.setRadiusConer()
        //get new 
        MBProgressHUD.showAdded(to: self.newCollectionView, animated: true)
        ApiClient.sharedInstance.getNews { ( news) in
            if news != nil {
                self.news  = news
                self.newCollectionView.reloadData()
//                print("--- \(news!)")
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.newCollectionView, animated: true)
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: CollectionViewDelegate , Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == newCollectionView {
            if self.news != nil {
                return self.news!.count
            }else{
                return 0
            }
        }
        return 10
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionViewCellID", for: indexPath) as! NewCollectionViewCell
        if collectionView == self.newCollectionView {
            let new = news![indexPath.row]
            cell.titleLbl.text = new.title
            cell.contentLbl.text = new.content
            cell.newImgView.downloadedFrom(link: new.imageUrl)
            cell.contentView.layer.borderColor = UIColor.gray.cgColor
            cell.contentView.layer.borderWidth = 1.0
//            cell.contentView.layer.cli
        }
        
        return cell
    }
    
    //UIEdgeInsetsMake(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(5, 1, 1, 1)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return CGSize( width: self.view.bounds.width/3 - 2, height: self.view.bounds.width/3)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 1
//    }
}

