//
//  CartPageRouter.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//
import Foundation
class CartPageRouter:PresenterToRouterCartPageProtocol{
    static func createModule(ref: CartPageVC) {
        
        let presenter = CartPagePresenter()
        ref.cartPagePresenterObject = presenter
        ref.cartPagePresenterObject?.cartPageInteractor = CartPageInteractor()
        ref.cartPagePresenterObject?.cartPageView = ref
        ref.cartPagePresenterObject?.cartPageInteractor?.cartPagePresenter = presenter
        
    }}
