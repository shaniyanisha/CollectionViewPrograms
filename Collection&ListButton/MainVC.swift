//
//  ViewController.swift
//  Collection&ListButton
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
class picturemodel{ //

    var name : String
    var color : String
    init( dict data:[String:String] ){
        name = data["picturename"]!
        color = data["pictureImage"]!
    }
}
enum listToGrid{ // for checking the selected layout
    case GridFlowLayoutUsed
    case ListFlowLayoutUsed }
class MainVC: UIViewController  {
    
    var checkingLayout = listToGrid.GridFlowLayoutUsed// object of enum with default grid layout
    
    var listViewobject = ListViewCell() // object of listViewCell class
    var gridViewobject = CollectionViewCell()// object of CollectionViewCell
    let picturesDictionary : [[String:String]] = [["picturename":"party","pictureImage":"women"],
          ["picturename":"party","pictureImage":"women"],["picturename":"party","pictureImage":"women"],["picturename":"party","pictureImage":"women"],["picturename":"party","pictureImage":"women"],["picturename":"party","pictureImage":"img"],["picturename":"party1","pictureImage":"img"],["picturename":"party1","pictureImage":"img"],
              ["picturename":"party1","pictureImage":"img"],
         ["picturename":"party","pictureImage":"img"],["picturename":"party","pictureImage":"img"],["picturename":"party","pictureImage":"img"],["picturename":"party1","pictureImage":"img"],["picturename":"party1","pictureImage":"img"],
        ["picturename":"party1","pictureImage":"img"]
    ]
    @IBOutlet weak var imagesView: UICollectionView!
    @IBAction func gridButton(_ sender: Any) {
    // change to grid layout
        checkingLayout = .GridFlowLayoutUsed
        
        UIView.animate(withDuration: 0.9) { () -> Void in
            self.imagesView.collectionViewLayout.invalidateLayout()
            self.imagesView.setCollectionViewLayout(self.gridViewobject, animated: true)
    }
    }
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func listButton(_ sender: Any) {
        // change to list layout

        checkingLayout = .ListFlowLayoutUsed

        UIView.animate(withDuration: 0.9) { () -> Void in
            self.imagesView.collectionViewLayout.invalidateLayout()
            self.imagesView.setCollectionViewLayout(self.listViewobject, animated: true)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePicture.layer.cornerRadius = self.profilePicture.layer.bounds.width/2.5 //corner radius for profilepicture
        self.profilePicture.clipsToBounds = true
        imagesView.dataSource = self
        imagesView.delegate = self
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(selecetCell)) // for adding gesture
        longPressGesture.delegate = self
        longPressGesture.minimumPressDuration = 0.5
        imagesView.addGestureRecognizer(longPressGesture)
        imagesView.allowsSelection = false
         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MainVC :UICollectionViewDelegate , UICollectionViewDataSource ,UIGestureRecognizerDelegate {
    
    
         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {// counting the number of rows in table
    
            return picturesDictionary.count
    }
        
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        if checkingLayout == .GridFlowLayoutUsed{ //checks if gridlayout
            
            let pictureModelObject = picturemodel(dict : picturesDictionary[indexPath.item])
            
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier:"pictureCellID", for: indexPath) as! pictureCell// object for gridlayout
            gridCell.configuirePictureCell(object: pictureModelObject)
            gridCell.layer.borderColor = UIColor.black.cgColor//border of gridcell blue
            gridCell.layer.borderWidth = 2 // cell border width 2
            return gridCell }
    
      
        else{
            let pictureModelObject = picturemodel(dict : picturesDictionary[indexPath.item])
            
            let listCell = collectionView.dequeueReusableCell(withReuseIdentifier:"pictureCellID", for: indexPath) as! pictureCell
            listCell.configuirePictureCell(object: pictureModelObject)
            listCell.layer.borderColor = UIColor.black.cgColor
            listCell.layer.borderWidth = 2
            return listCell

        }
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let cell = self.imagesView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.black
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        let cell = self.imagesView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    func selecetCell(gesture : UILongPressGestureRecognizer!){
        if gesture.state == .ended {
            return
        }
        imagesView.allowsMultipleSelection = true
        imagesView.allowsSelection = true
        
        let p = gesture.location(in: self.imagesView)
        
        if let indexPath = self.imagesView.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            let cell = self.imagesView.cellForItem(at: indexPath)
            cell!.isSelected = true
            cell?.backgroundColor = UIColor.blue
            
            // do stuff with the cell
        } else {
            print("couldn't find index path")
            imagesView.allowsMultipleSelection = false
            imagesView.allowsSelection = false
        }
    }
}

class pictureCell : UICollectionViewCell{
    
    @IBOutlet weak var galleryImage: UIImageView!
    
    @IBOutlet weak var galleryImageName: UILabel!
   
       func configuirePictureCell(object :picturemodel){ // configure the
        
        
            galleryImage.image = UIImage(named: object.color)
           galleryImageName.text = object.name

    }
}

