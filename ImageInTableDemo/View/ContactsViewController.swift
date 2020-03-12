//
//  ContactsViewController.swift
//  contactsapp
//
//  Created by SoftAuthor on 2019-04-20.
//  Copyright © 2019 SoftAuthor. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   // private let contacts = ContactAPI.getContacts() // model
    
    let contactsTableView = UITableView() // view
     var spinner = UIActivityIndicatorView()
    
    // MARK: - Injection
    let viewModel = ViewModel(dataService: DataService())
     var userDetails:UserDetails!

    fileprivate func addCustomTable() {
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.contactsTableView.estimatedRowHeight = 85.0
            self.contactsTableView.rowHeight = UITableView.automaticDimension
            self.view.addSubview(self.contactsTableView)
            
            
            
        self.contactsTableView.translatesAutoresizingMaskIntoConstraints = false
  self.contactsTableView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    self.contactsTableView.leftAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    self.contactsTableView.rightAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.contactsTableView.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.contactsTableView.dataSource = self
            self.contactsTableView.delegate = self
            self.addSpinnerInTableView()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attemptFetchPhoto()
       

        
//      contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "contactCell")
        contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")


    }
    // MARK: - Networking
    private func attemptFetchPhoto() {
        viewModel.fetchPhoto()
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            
            self.userDetails = self.viewModel.userInfo
            DispatchQueue.main.async {
            self.title = self.userDetails.title
                       }
            self.addCustomTable()
        }
    }
   func addSpinnerInTableView(){
         spinner = UIActivityIndicatorView(style: .gray)
         spinner.stopAnimating()
         spinner.hidesWhenStopped = true
         spinner.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60)
    self.contactsTableView.tableFooterView = spinner
     }
    // MARK: - UI Setup
       private func activityIndicatorStart() {
           // Code for show activity indicator view
           // ...
           print("start")
       }
       
       private func activityIndicatorStop() {
           // Code for stop activity indicator view
           // ...
           print("stop")
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.userDetails.userRows?.count )!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let item = userDetails.userRows?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        cell.setupDataFromModel(model: item!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
              let offset = scrollView.contentOffset
              let bounds = scrollView.bounds
              let size = scrollView.contentSize
              let inset = scrollView.contentInset

              let y = offset.y + bounds.size.height - inset.bottom
              let h = size.height

              let reloadDistance = CGFloat(30.0)
              if y > h + reloadDistance {
                  spinner.startAnimating()
                  //MARK: call getApiCall method when more data to show in tableView
                  print("fetch more data")
                   // not call api here so for demo purpose stop animation
                   let seconds = 1.0
                   DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                      self.spinner.stopAnimating()
                   }
                  
              }
      }

}

