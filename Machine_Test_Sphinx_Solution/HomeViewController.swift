//
//  ViewController.swift
//  Machine_Test_Sphinx_Solution
//
//  Created by Mac on 04/03/23.
//

import UIKit
import GoogleMaps
class HomeViewController: UIViewController {

    @IBOutlet weak var populationTableView: GMSMapView!
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    var urlString : String?
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var newUser : User?
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        userCollectionView.delegate = self
        userCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        self.userCollectionView.register(nibName, forCellWithReuseIdentifier: "UserCollectionViewCell")
        
        userSeriallization()
    }
    
    func userSeriallization(){
         urlString = "https://gorest.co.in/public/v2/users"
        url = URL(string: urlString!)
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"

        urlSession = URLSession(configuration: .default)

        let dataTask = urlSession?.dataTask(with: urlRequest!){
            data ,response, error in
            let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
            for eachUser in jsonObject{
                let userId = eachUser["id"] as! Int
                let userName = eachUser["name"] as! String
                let userGender = eachUser["gender"] as! String

                self.newUser = User(id: userId, name: userName, gender: userGender)
                self.user.append(self.newUser!)

            }
            DispatchQueue.main.async {
                self.userCollectionView.reloadData()
            }
        }
        dataTask?.resume()
    }
    
    func populationDecode(){
        var url : URL?
        var urlString : String?
        var urlRequest : URLRequest?
        var urlSession : URLSession?
        
        urlString = "
        
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewHeight = view.frame.size.height
        let viewWidth = view.frame.size.width
        return CGSize(width: viewWidth * 0.50, height: viewHeight * 0.40)
    }
}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCollectionViewCell = self.userCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        let eachUser = user[indexPath.row]
        userCollectionViewCell.idLabel.text = String(eachUser.id)
        userCollectionViewCell.nameLabel.text = String(eachUser.name)
        userCollectionViewCell.genderLabel.text = String(eachUser.gender)
        return userCollectionViewCell
    }
    
    
}
