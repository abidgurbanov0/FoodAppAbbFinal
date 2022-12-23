//
//  DetailPageRouter.swift
//  FoodEr
//
//  Created by Abid Qurbanov on 14.12.2022.
//

import Foundation
class DetailPageRouter{
    static func createModule(ref: DetailPageVC){
        let presenter = DetailPagePresenter()
        ref.detailPagePresenterObject = presenter
        ref.detailPagePresenterObject?.detailPageInteractor = DetailPageInteractor()
        ref.detailPagePresenterObject?.detailPageInteractor?.detailPagePresenter = presenter
        ref.detailPagePresenterObject?.detailPageView = ref
        
    }
}
