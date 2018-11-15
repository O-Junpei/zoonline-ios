import UIKit
import PageMenu

class FieldVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //CollectionViews
    var newCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションアイテムを作成
        let titleLabel:NavigationBarLabel = NavigationBarLabel()
        titleLabel.frame = CGRect(x: view.frame.width*0.3, y: 0, width: view.frame.width*0.4, height: 40)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "ひろば"
        titleLabel.textColor = UIColor.white
        self.navigationItem.titleView = titleLabel

        
        
        let collectionFrame = self.view.frame
        let layout = FieldCollectionViewFlowLayout()
        newCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        newCollectionView.backgroundColor = UIColor.white
        newCollectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        newCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        newCollectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        newCollectionView.delegate = self
        newCollectionView.dataSource = self
        if #available(iOS 11.0, *) {
            newCollectionView.contentInsetAdjustmentBehavior = .never
        }
        
        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        newCollectionView.refreshControl = refreshControl
        self.view.addSubview(newCollectionView)
        
        newCollectionView.collectionViewLayout.invalidateLayout()
        let layout2 = FieldCollectionViewFlowLayout()
        newCollectionView.setCollectionViewLayout(layout2, animated: false)
    }


    
    
    @objc func scrollReflesh(sender : UIRefreshControl) {

    }
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")
    }
    
    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:  NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 16
        cell.thumbnailImgView?.image = UIImage(named: "no_img")
        return cell
    }
    
}