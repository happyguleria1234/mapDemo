//
//  ListVC.swift
//  mapDemo
//
//  Created by Happy Guleria on 11/05/25.
//

import UIKit
import Foundation
import CoreLocation

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblList: UITableView!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MarkerStore.shared.markers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblList.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.lbl_name.text = "\(round(MarkerStore.shared.markers[indexPath.row].coordinate.latitude))"
        cell.lbl_long.text = "\(round(MarkerStore.shared.markers[indexPath.row].coordinate.longitude))"
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(deleteMarker(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @objc func deleteMarker(_ sender: UIButton) {
        guard sender.tag < MarkerStore.shared.markers.count else { return }
        MarkerStore.shared.markers.remove(at: sender.tag)
        MarkerStore.shared.saveMarkerData()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("MarkerUpdated"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("MarkerUpdated"), object: nil)
        let index = IndexPath(row: sender.tag, section: 0)
        tblList.deleteRows(at: [index], with: .fade)
    }
   
}

class ListCell: UITableViewCell {
    
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var lbl_long: UILabel!
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        main_view.layer.borderWidth = 1
        main_view.layer.cornerRadius = 8
        main_view.layer.masksToBounds = true
        main_view.layer.borderColor = UIColor.lightGray.cgColor
        main_view.backgroundColor  = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
    }
    
}

