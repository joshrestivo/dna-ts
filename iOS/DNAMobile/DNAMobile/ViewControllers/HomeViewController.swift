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
    @IBOutlet weak var contentLbl: MarginLabel!
    var news:[New]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestServiceBtn.setRadiusConer()
        contentLbl.setRadiusConer()
        initScreen()
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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initScreen(){
        self.navigationItem.title = "DNA"
        self.navigationController!.navigationBar.barTintColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.backgroundColor = ConstantHelper.redColor
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            if indexPath.row > 2 {
                cell.newImgView.downloadedFrom(link: new.imageUrl)    
            }
        }
       
        return cell
    }
    
    //UIEdgeInsetsMake(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(5, 1, 1, 1)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize( width: self.view.bounds.width - 80, height: newCollectionView.bounds.size.height - 10)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pushToNewDetail", sender: nil)
    }
}
