//
//  DetailPageInteractor.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
import FirebaseAuth
import Alamofire
import Firebase
class DetailPageInteractor:PresenterToInteractorDetailPageProtocol{
    var detailPagePresenter: InteractorToPresenterDetailPageProtocol?
    var adet = 1
    
    
    func isFavedI(food:Foods){
        let uid = Auth.auth().currentUser?.uid
        let ref =  Database.database().reference().child("users").child(uid!).child("favorites")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.hasChild(food.name!){

                self.detailPagePresenter?.isFavedToPresenter(isFaved: true)

                }else{

                    self.detailPagePresenter?.isFavedToPresenter(isFaved: false)
                }


            })
        
        
    }
      
    func addFavI(food:Foods){
        let uid = Auth.auth().currentUser?.uid
        let ref =  Database.database().reference().child("users").child(uid!).child("favorites")
       
        
        let favFood = ["foodName":food.name, "foodPrice": food.price,"foodImageName": food.image,"foodID":food.id]  as [String:Any]

        ref.child(food.name!).setValue(favFood)
        
        
        
        
        
    }
    func deleteFavI(food:Foods){
        let uid = Auth.auth().currentUser?.uid
        let ref =  Database.database().reference().child("users").child(uid!).child("favorites")
        
        
        
        
        ref.child(food.name!).removeValue()
        
    }
    
   func getCartInfoI() {
        let userInfo = Auth.auth().currentUser
        let userEmail = userInfo?.email

        if let email = userEmail{
            let param : Parameters = ["userName":email]
            
            AF.request("http://kasimadalan.pe.hu/foods/getFoodsCart.php", method: .post, parameters: param).response { response in
                if let data = response.data {
                    
                    do {
                        let answer = try JSONDecoder().decode(FoodsCartResponse.self, from: data)
                        
                        if let answerArray = answer.foods_cart {
                            self.detailPagePresenter?.cartInfoToPresenter(cartFood: answerArray)

                        }
                        
                    } catch  {
                        
                        print(error.localizedDescription)
                    }
                }
            }}
    }
    
    func deleteFromCartI(sepet_yemek_id: String, kullanici_adi: String) {
        if kullanici_adi ==  Auth.auth().currentUser?.email{
            let param : Parameters = ["cartId":sepet_yemek_id,"userName":kullanici_adi]
            AF.request("http://kasimadalan.pe.hu/foods/deleteFood.php", method: .post, parameters: param).response { response in
                if let data = response.data {
                    do{
                        let answer = try JSONSerialization.jsonObject(with: data)
                        print(answer)
                   
                    }catch{
                        print("sil")
                        print(error.localizedDescription)
                    }
                    
                    
                }}
            
            
        }
    }
    
    
    
    
    
    
    
    
    func addToCartI(food:Foods,adet:String) {
        let userInfo = Auth.auth().currentUser
        let email = userInfo?.email

        if let yemek_adi = food.name,let yemek_resim_adi = food.image, let yemek_fiyat = food.price{
            let intFiyat = yemek_fiyat
            if let intAdet = Int(adet){

                let params:Parameters = ["name":yemek_adi,"image":yemek_resim_adi,"price":intFiyat,"category":"" ,"orderAmount": intAdet,"userName":email!]
            
            AF.request("http://kasimadalan.pe.hu/foods/insertFood.php",method: .post,parameters: params).response { response in
                if let data = response.data {
                    do{
                        let cevap = try JSONSerialization.jsonObject(with: data)
                        print(cevap)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            
            }} }
    
  
    func minusI() {
        adet -= 1
        detailPagePresenter?.adetDataToPresenter(number: adet)
        
    }
    
    func plusI() {
        adet += 1
        detailPagePresenter?.adetDataToPresenter(number: adet)
    }
    
    func setTotalPriceI(price:Int) {
        let totalPrice = price * adet
        detailPagePresenter?.totalPriceDataToPresenter(number: totalPrice)
        
    }
    
    
}
