//
//  Protocols.swift
//  NotesApp
//
//  Created by Macbook on 29/06/23.
//

protocol HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?)
}
protocol CollectionViewDataProtocol{
    func deleteData(indx: Int)
    func setNotification(indx: Int)
}
protocol TrashCollectionViewDataProtocol{
    func permanentDelete(indx: Int)
    func recoverData(indx: Int)
}
