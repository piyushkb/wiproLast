//
//  ViewModel.swift
//  MVVMProject
//
//  Created by MACBOOK PRO RETINA on 25/12/2018.
//  Copyright © 2018 MACBOOK PRO RETINA. All rights reserved.
//

import Foundation
class ViewModel {
    
    // MARK: - Properties
     var userInfo: UserDetails? {
        didSet {
            guard let p = userInfo else { return }
            self.setupText(p)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    var mainTitle:String?
    var titleString: String?
    var desString: String?
    var photoUrl: String?
    
    
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchPhoto() {
        self.dataService?.getApiCall(completion: { (data, error) in
            
       
            if let error = error {
                self.error = error as? Error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.userInfo = data as? UserDetails
        })
    }
    
    // MARK: - UI Logic
    private func setupText(_ userInfo: UserDetails) {
        if let mainTitle = userInfo.title{
            self.mainTitle = "Title: \(mainTitle)"
            }
        
        getUserDetails()
    }
    fileprivate func getUserDetails() {
        for item in self.userInfo?.userRows ?? [] {
               if let imageUrl = item.imageHref{
                   if(!imageUrl.isEmpty) {
                       titleString = item.title ?? "No Title"
                       desString = item.description ?? "No Description"
//                      guard let formattedUrlString = String.replaceHttpToHttps(with: imageUrl), let url = URL(string: formattedUrlString) else {
//                           return
//                       }
                       self.photoUrl = imageUrl
                   }
                   
               }
           }
       }
    
}
//protocol ViewModelDelegate {
//    func onItemAddClick(phoneName: String,phoneNumber: String)
//}
//
//protocol reloadTableViewDelegate {
//    func reloadTableView(index: Int)
//}
//
//class ViewModel {
//
//    var items = [Model]()
//    var reloadDelegate: reloadTableViewDelegate?
//    var itemJson = [["phoneContactNumber":"71111111","phoneContactName":"Omar Thamri"],
//                    ["phoneContactNumber":"72222222","phoneContactName":"Bill Gates"],
//                    ["phoneContactNumber":"73333333","phoneContactName":"Jeff Bezos"]]
//
//    init(viewDelegate: reloadTableViewDelegate) {
//        reloadDelegate = viewDelegate
//        self.items = Model.modelFromDictionnaryArray(array: itemJson as! NSArray)
//        print("items count",items.count)
//    }
//
//}
//
//extension ViewModel: ViewModelDelegate {
//    func onItemAddClick(phoneName: String,phoneNumber: String) {
//        items.append(Model(phoneContactNumber: phoneNumber, phoneContactName: phoneName))
//        reloadDelegate?.reloadTableView(index: items.count)
//    }
//
//
//}
