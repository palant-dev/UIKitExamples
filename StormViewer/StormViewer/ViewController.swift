//
//  ViewController.swift
//  StormViewer
//
//  Created by Antonio Palomba on 26/08/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let fm = FileManager.default
        // Force unwrapping this is safe because apple apps has always a resources path
        let path = Bundle.main.resourcePath!
        // This is a force unwrapping justified because if it crash is ok because the app is broken and should be immediately stop
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }

        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    // https://www.hackingwithswift.com/read/1/3/designing-our-interface 11:00
}

