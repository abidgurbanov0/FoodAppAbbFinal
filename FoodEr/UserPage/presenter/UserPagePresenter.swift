//
//  UserPagePresenter.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
import UIKit
class UserPagePresenter:ViewToPresenterUserPageProtocol, InteractorToPresenterUserPageProtocol{

    
    
    var userPageInteractor: PresenterToInteractorUserPageProtocol?
    
    var userPageView: PresenterToViewUserPageProtocol?
    func deleteFoodFromFavList(yemek_adi: String) {
        userPageInteractor?.deleteFoodFromFavListI(yemek_adi: yemek_adi)
    }
    
    func getFavFoodList() {
        userPageInteractor?.getFavFoodListI()
    }
    
    func favListToPresenter(favFoodList: [Foods]) {
        userPageView?.favListToView(favFoodList: favFoodList)
    }
    
    
    func updateUserInfo(user_Name: String, user_Surname: String, user_Phone: String) {
        userPageInteractor?.updateUserInfoI(user_Name: user_Name, user_Surname: user_Surname, user_Phone: user_Phone)
    }
    
    
   
    
  
    
    func imageToPresenter(user_Image: UIImage) {
        userPageView?.imageToView(user_Image: user_Image)
    }
    
 
    func dataToPresenter(user_Name:String,user_Surname:String,user_Phone:String){
        userPageView?.dataToView(user_Name: user_Name, user_Surname: user_Surname, user_Phone: user_Phone)
    }
    func getUserInfoFromFireBase() {
        userPageInteractor?.getUserInfoFromFireBaseI()
    }
    
   
    
    
}
