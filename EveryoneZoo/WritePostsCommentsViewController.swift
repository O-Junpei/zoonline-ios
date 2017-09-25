//
//  WritePostsCommentsViewController.swift
//  EveryoneZoo
//
//  Created by junpei ono on 2017/08/30.
//  Copyright © 2017年 junpei ono. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView

class WritePostsCommentsViewController: UIViewController {
    
    var postsID:Int!
    
    //width, height
    private var viewWidth:CGFloat!
    private var viewHeight:CGFloat!
    private var statusBarHeight:CGFloat!
    private var navigationBarHeight:CGFloat!
    private var tabBarHeight:CGFloat!
    var textViewHeight:CGFloat!

    //テーブルビューインスタンス
    private var commentTextView: UITextView!
    
    //Indicater
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Viewの大きさを取得
        viewWidth = self.view.frame.size.width
        viewHeight = self.view.frame.size.height
        statusBarHeight = (self.navigationController?.navigationBar.frame.origin.y)!
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
        textViewHeight = viewHeight - (statusBarHeight + navigationBarHeight + tabBarHeight)
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        setTextView()
        
        setActivityIndicator()
    }
    
    
    // MARK: - Viewにパーツの設置
    // MARK: NavigationBar
    func setNavigationBar() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.mainAppColor()
        self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: viewWidth*0.3, y: 0, width: viewWidth*0.4, height: navigationBarHeight)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "コメント"
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        //バーの右側に設置するボタンの作成
        let rightNavBtn = UIBarButtonItem()
        rightNavBtn.image = UIImage(named:"submit_nav_btn")!
        rightNavBtn.action = #selector(postNavBtnClicked(sender:))
        rightNavBtn.target = self
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    
    func setTextView(){
        
        // TextView生成する.
        commentTextView = UITextView()
        commentTextView.frame = CGRect(x:0, y:0, width:viewWidth, height:textViewHeight)
        commentTextView.text = ""
        commentTextView.font = UIFont.systemFont(ofSize: 20.0)
        commentTextView.textColor = UIColor.black
        self.view.addSubview(commentTextView)
        
        //キーボードは出しておく
        commentTextView.becomeFirstResponder()
    }
    
    // MARK: くるくるの生成
    func setActivityIndicator(){
        
        indicator.frame = CGRect(x: viewWidth*0.35, y: viewWidth*0.5, width: viewWidth*0.3, height: viewWidth*0.3)
        indicator.clipsToBounds = true
        indicator.layer.cornerRadius = viewWidth*0.3*0.3
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor.mainAppColor()
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        indicator.center = self.view.center
        self.view.bringSubview(toFront: indicator)
        indicator.color = UIColor.white
        self.view.addSubview(indicator)
    
    }
    
    // MARK: -
    func postNavBtnClicked(sender: UIButton){
        
        if commentTextView.text.isEmpty {
            SCLAlertView().showInfo("エラー", subTitle: "コメントに文字の入力必要だよ")
            return
        }
        
        //indicatrer
        indicator.startAnimating()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let myUserID:String = (appDelegate.userDefaultsManager?.userDefaults.string(forKey: "KEY_MyUserID"))!
        
        let parameters: Parameters = [
            "post_id": String(postsID),
            "user_id": myUserID,
            "comments": commentTextView.text
        ]
        
        Alamofire.request(API_URL+API_VERSION+COMMENTS, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
            
            switch response.result {
            case .success:
                
                let json:JSON = JSON(response.result.value ?? kill)
                print(json)
                
            case .failure(let error):
                print(error)
            }
            
            self.indicator.stopAnimating()
        }
    }
}
