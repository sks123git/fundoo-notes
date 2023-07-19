//
//  ViewController.swift
//  NotesApp
//
//  Created by Macbook on 21/06/23.
//

import UIKit

var setTimerForCollectionIndex: Int = 0

class MainViewController: UIViewController {
    var models: [Note] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    var noteService = NoteService()
    var notesDocID: String = ""
    var searching = false
    var searchedResult = [Note]()
    var sideBarView: UIView!
    var tableView: UITableView!
    var isEnableSidebarView: Bool = false
    var swipeToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    var tempView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkIfAlreadyLoggedIn()
        configureSearchController()
        
        sideBarView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height))
        tableView.backgroundColor = .lightGray
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(tableView)
        tableView.isOpaque = true
        
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedToRight))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipedToLeft))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        tempView = UIView(frame: CGRect(x: self.view.bounds.width/1.5, y: 0, width: self.view.bounds.width-(self.view.bounds.width/1.5), height: self.view.bounds.height))
        self.view.addSubview(tempView)
        tempView.isHidden = true
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempView.addGestureRecognizer(tapGesture)
    }
    
    @objc func closeSideBarView(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.5){
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        isEnableSidebarView = false
    }
    
    @objc func didSwipedToRight(){
        self.view.addGestureRecognizer(swipeToLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        UIView.animate(withDuration: 0.5){
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
        }
        self.tempView.isHidden = false
        isEnableSidebarView = true
    }
    
    @objc func didSwipedToLeft(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.5){
            self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            
            self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
        }
        self.tempView.isHidden = true
        isEnableSidebarView = false
    }
    
    @IBAction func didTapMenu(){
        
        if isEnableSidebarView{
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipeToLeft)
            UIView.animate(withDuration: 0.5){
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
                
                self.tableView.frame = CGRect(x: 0, y: 0, width: 0, height: self.view.bounds.height)
            }
            self.tempView.isHidden = true
            isEnableSidebarView = false
        }else{
            self.view.addGestureRecognizer(swipeToLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            UIView.animate(withDuration: 0.5){
                self.sideBarView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
                
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width/1.5, height: self.view.bounds.height)
            }
            self.tempView.isHidden = false
            isEnableSidebarView = true
        }
    }
    
    
    @IBAction func didChangeViewONTap(_ sender: Any) {
        if Constants.View.changeViewToLandscape == true{
            Constants.View.changeValueTo = 0
            Constants.View.changeViewToLandscape = false
            self.myCollectionView.reloadData()
        } else {
            Constants.View.changeValueTo = 10
            Constants.View.changeViewToLandscape = true
            self.myCollectionView.reloadData()
        }
        self.myCollectionView.reloadData()
    }
    
//    func didSelectMenuOption(menuOption: String){
//        switch menuOption{
//        case "profile":
//            print("show profile")
//        case "inbox":
//            print("show inbox")
//        case "trash":
//            print("inside trash")
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            guard let vc = storyboard.instantiateViewController(withIdentifier: "bin") as? BinViewController else {
//                print("error")
//                return
//            }
//            print("bin vc created")
////            self.navigationController?.pushViewController(vc, animated: true)
//            let nav = UINavigationController(rootViewController: vc)
//            DispatchQueue.main.async {
//                self.present(nav, animated: true)
//            }
//
//        case "logout":
//            self.didTapToLogout()
//        default:
//            print("")
//        }
//    }
    
    func didTapToLogout(){
        AuthService.logOut { isLogoutSuccess in
            if isLogoutSuccess{
                let scene = UIApplication.shared.connectedScenes.first
                if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.signupAndLoginViewController) as? SignupLoginViewController
                    sd.window?.rootViewController = UINavigationController(rootViewController: homeViewController!)
                    self.view.window?.makeKeyAndVisible()
                }
            }else{
                
            }
        }
    }
    
    @IBAction func didTapToNewNote(_ sender: UIBarButtonItem) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "new") as? NewNoteViewController else{
            return
        }
        vc.title = "New Note"
        vc.completion = {
            notetitle, note, uid, isDeleted in
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? MainViewController
                sd.window?.rootViewController = UINavigationController(rootViewController: homeViewController!)
                self.view.window?.makeKeyAndVisible()
                
            }
            self.models.append(Note.init(uid: uid, title: notetitle, note: note, isDeleted: isDeleted))
            self.noteService.addToDatabase(notetitle: notetitle, note: note, uid: uid, isDeleted: isDeleted)
            self.myCollectionView.isHidden = false
            self.myCollectionView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "search"
    }
}

// populating tableview with notes
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            searchedResult.removeAll()
            for item in models{
                if item.title?.lowercased() == searchText.lowercased(){
                    searchedResult.append(item)
                }
            }
            
        }else{
            searching = false
            searchedResult.removeAll()
            searchedResult = models
        }
        myCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedResult.removeAll()
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchedResult.count
        }else{
            return models.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        if searching {
            cell.titleText.text = searchedResult[indexPath.item].title
            cell.labelText.text = searchedResult[indexPath.item].note
        }else{
            cell.titleText.text = models[indexPath.item].title
            cell.labelText.text = models[indexPath.item].note
        }
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.index  = indexPath
        cell.delegate = self
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - CGFloat(Constants.View.changeValueTo))/2
        if Constants.View.changeViewToLandscape == true {
            return CGSize(width: size, height: size)}
        else{
            return CGSize(width: collectionView.frame.size.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        myCollectionView.deselectItem(at: indexPath, animated: true)
        // showing note controller
        let model = models[indexPath.item]
        guard let vc  = storyboard?.instantiateViewController(withIdentifier: "note") as? NoteViewController else {
            return
        }
        vc.title = "Note"
        if model.title != nil && model.note != nil{
            vc.noteTitle = model.title!
            vc.note = model.note!
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    // Slide to delete note
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func checkIfAlreadyLoggedIn(){
        noteService.fetchData(isDeleted: false) { notes in
            DispatchQueue.main.async {
                        self.models = notes
                        self.myCollectionView?.reloadData()
                    }
                }
            }
        }
extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray
        cell.textLabel?.textColor = .white
        if let menu = MenuOption(rawValue: indexPath.row)?.description {
            cell.textLabel?.text = menu
        } else {
            print("Invalid menu type")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let menuOption = MenuOption(rawValue: indexPath.row)?.description else{
            return
        }
        switch menuOption{
        case "profile":
            print("show profile")
        case "reminders":
            print("show inbox")
        case "trash":
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "bin") as? BinViewController else {
                print("error")
                return
            }
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true)
            
        case "logout":
            self.didTapToLogout()
        default:
            print("")
        }
//        mainViewController.didSelectMenuOption(menuOption: menuOption)
    }
}

extension MainViewController: CollectionViewDataProtocol{
    func setNotification(indx: Int) {
        setTimerForCollectionIndex = indx
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "timeInputVC") as? TimeInputController else{
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func deleteData(indx: Int) {
        guard let notesDocID = models[indx].uid else {
            return
        }
        noteService.tempDeleted(notesDocID: notesDocID, isDeleted: true)
        self.models.remove(at: indx)
        self.myCollectionView.reloadData()
    }
}
