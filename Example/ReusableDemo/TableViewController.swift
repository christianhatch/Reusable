//
//  ViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  var boolValues = [false, false]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.registerReusableCell(MySimpleColorCell.self)
    tableView.registerReusableCell(MyXIBTextCell.self)
    tableView.registerReusableCell(MyXIBSwitchCell.self)
    /* No need to register this one, the UIStoryboard already auto-register its cells */
//    tableView.registerReusableCell(MyStoryBoardIndexPathCell)
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyHeaderTableView.height
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = MyHeaderTableView.loadFromNib()
    view.fillForSection(section: section)
    return view
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 4
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let colorCell = tableView.dequeueReusableCell(indexPath as IndexPath) as MySimpleColorCell
      let red: CGFloat = indexPath.row == 0 ? 1.0 : 0.0
      colorCell.fill(color: UIColor(red: red, green: 0.0, blue: 1-red, alpha: 1.0))
      return colorCell
    case 1:
      let textCell = tableView.dequeueReusableCell(indexPath as IndexPath) as MyXIBTextCell
      textCell.fill(text: "{section \(indexPath.section), row \(indexPath.row)}")
      return textCell
    case 2:
      let boolCell = tableView.dequeueReusableCell(indexPath as IndexPath) as MyXIBSwitchCell
      boolCell.fill(title: "Switch #\(indexPath.row)", value: boolValues[indexPath.row]) {
        [unowned self] in self.boolValues[indexPath.row] = $0
      }
      return boolCell
    case 3:
      let pathCell = tableView.dequeueReusableCell(indexPath as IndexPath) as MyStoryBoardIndexPathCell
      pathCell.fill(indexPath: indexPath)
      return pathCell
    default:
      fatalError("Out of bounds, should not happen")
    }
  }
}
