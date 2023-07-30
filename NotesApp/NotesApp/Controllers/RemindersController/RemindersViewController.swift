//
//  RemindersViewController.swift
//  NotesApp
//
//  Created by Macbook on 22/07/23.
//

import UIKit

class RemindersViewController: UIViewController {
    
    var reminderCollectionView: UICollectionView!
    var titleLabel = UILabel()
    static let identifier = "ReminderView"
    var models: [Note] = []
    var noteService = NoteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
    func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat =  12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func configureCollectionView(){
        reminderCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout(in: view))
        view.addSubview(titleLabel)
        view.addSubview(reminderCollectionView)
        reminderCollectionView.delegate = self
        reminderCollectionView.dataSource = self
        reminderCollectionView.backgroundColor = .systemBackground
        reminderCollectionView.register(ReminderViewCell.self, forCellWithReuseIdentifier: ReminderViewCell.reusableID)
        
        titleLabel.text = "Reminders"
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = .systemBackground
        reminderCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            reminderCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            reminderCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reminderCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reminderCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension RemindersViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reminderCollectionView.dequeueReusableCell(withReuseIdentifier: ReminderViewCell.reusableID, for: indexPath) as! ReminderViewCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.blue.cgColor
        noteService.fetchDataHavingReminders(){
                models in
            self.models = models
            }
        cell.titlelabel.text = models[indexPath.item].title
        cell.notesLabel.text = models[indexPath.item].note
        return cell
    }
}
