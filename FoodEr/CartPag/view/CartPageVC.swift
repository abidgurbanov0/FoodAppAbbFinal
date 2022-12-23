//
//  CartPageVC.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import UIKit
import Kingfisher
class CartPageVC: UIViewController {
    
    
    @IBOutlet weak var buttonDeleteAll: UIButton!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var totalPrice2: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    var totalCartPrice = 0
    var cartPagePresenterObject : ViewToPresenterCartPageProtocol?
   
    var allFoodsCart = [FoodsCart]()
    override func viewDidLoad() {
       
        
       
        
        CartPageRouter.createModule(ref: self)
        tableView.dataSource = self
        tableView.delegate = self
        tabBarController?.selectedIndex = 0
        super.viewDidLoad()

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        cartPagePresenterObject?.getCartFood()
        
    }

  

    @IBAction func buttonDeleteAll(_ sender: Any) {
        indicator.startAnimating()
        let alert = UIAlertController(title: "Sebeti sil", message: "Hamisi silinsinmi? ", preferredStyle: .alert)
        
        let okeyAction = UIAlertAction(title: "Ok", style: .cancel){action in
            for i in self.allFoodsCart{
           
                
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: i.cartId!, kullanici_adi: i.userName!)
              
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        indicator.stopAnimating()
        alert.addAction(okeyAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
     
        
    }
    
    
    
    
    
    @IBAction func buttonOnay(_ sender: Any) {
        
        if totalCartPrice > 0 {
            let stringPrice = String(totalCartPrice)
            performSegue(withIdentifier: "toOrderDetailPage", sender: stringPrice)
        }else{
            let alert = UIAlertController(title: "Sebet bos", message: "Sebete mehsul elave et", preferredStyle: .alert)
            
            let okeyAction = UIAlertAction(title: "Ok", style: .default)
                
            
            alert.addAction(okeyAction)
            
            self.present(alert, animated: true)
            

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOrderDetailPage"{
            if let price = sender as? String{
                let gidilecekVC = segue.destination as! OrderDetailVC
                gidilecekVC.price = price
                gidilecekVC.delegate = self
            
            }
        }
    }
    
    
    
    
}





extension CartPageVC : PresenterToViewCartPageProtocol{
    func sendDataToView(foodsCart: [FoodsCart], totalPrice: Int) {
        indicator.startAnimating()
        
        self.allFoodsCart = foodsCart
        self.totalCartPrice = totalPrice
       self.totalPrice.text = "\(String(totalPrice)) azn"
        self.totalPrice2.text = "\(String(totalPrice)) azn"
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        
       
        if allFoodsCart.isEmpty{
            buttonDeleteAll.isEnabled = false
        }
        else{
            buttonDeleteAll.isEnabled = true
        }
        indicator.stopAnimating()
        
        
        if let tabItems = tabBarController?.tabBar.items{
            let cartItem = tabItems[0]
            let temp = self.allFoodsCart.count
            if temp > 0{
                cartItem.badgeValue = String(temp)
            }else{
                cartItem.badgeValue = nil
            }
           
            
        }
    }
  
    
}





extension CartPageVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFoodsCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let url = "http://kasimadalan.pe.hu/foods/images/"
        let tempFood = allFoodsCart[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartPageTableViewCell") as! CartPageTableViewCell
        
        cell.delegate = self
        cell.indexPath = indexPath
      
        if let url = URL(string: "\(url)\(tempFood.image!)"){
            DispatchQueue.main.async {
                cell.imageFood.kf.setImage(with : url)
            }
            
        }
        
        cell.labelName.text = tempFood.name
        
         let foodPrice = tempFood.price!
        let foodAdetInt = tempFood.orderAmount!
   
        let totalFoodPrice = foodPrice * foodAdetInt
            
        cell.labelPrice.text = "\(totalFoodPrice) azn"
            cell.labelAdet.text = "\(tempFood.orderAmount!)"
        
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){(contextualAction,view,bool) in
            let food = self.allFoodsCart[indexPath.row]
            
            let alert = UIAlertController(title: "Silme", message: "\(food.name!) silinsin mi?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Ok", style: .destructive){ action in
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: food.cartId!, kullanici_adi: food.userName!)
              
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    }
    
    



extension CartPageVC:OrderDetailToCartPage{
    func deleteCart() {
        for i in allFoodsCart{
            cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: i.cartId!, kullanici_adi: i.userName!)
        }
        self.cartPagePresenterObject?.getCartFood()
    }
    
    
}


extension CartPageVC:CartPlusOrMinus{
    
    func cartPlus(indexPath: IndexPath ) {
        
        indicator.startAnimating()
        let cartFood = allFoodsCart[indexPath.row]
      
        var adetInt = cartFood.orderAmount!
  
          adetInt += 1
          var  adet = (adetInt)
            cartPagePresenterObject?.changeCartFoodCount(yemek_adi: cartFood.name!, yemek_resim_adi: cartFood.image!, yemek_fiyat:( cartFood.price!),sepet_yemek_id: (cartFood.cartId!), yeniAdet: adet)
        

        
      
       
       
        
    }
    func cartMinus(indexPath: IndexPath) {
        
        indicator.startAnimating()
        let cartFood = allFoodsCart[indexPath.row]
        
        
        var adetInt = cartFood.orderAmount!
        if adetInt > 1{
            adetInt -= 1
            var adet = (adetInt)
        cartPagePresenterObject?.changeCartFoodCount(yemek_adi: cartFood.name!, yemek_resim_adi: cartFood.image!, yemek_fiyat: cartFood.price!,sepet_yemek_id: (cartFood.cartId!), yeniAdet: adet)
        }
        else if adetInt == 1{
            let alert = UIAlertController(title: "Silinme", message: "Sepetinizde \(cartFood.name!) 1 edet var.  ", preferredStyle: .alert)
            
            let okeyAction = UIAlertAction(title: "Ok", style: .cancel){action in
                self.cartPagePresenterObject?.deleteCartFood(sepet_yemek_id: (cartFood.cartId!), kullanici_adi: cartFood.userName!)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(okeyAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
            indicator.stopAnimating()
        }
        else {
         
            indicator.stopAnimating()
        }
          
       
      
    }
}
