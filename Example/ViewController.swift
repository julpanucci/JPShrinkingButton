//
//  ViewController.swift
//  Example
//
//  Created by Panucci, Julian on 10/5/18.
//  Copyright © 2018 Panucci, Julian. All rights reserved.
//

import UIKit
import JPShrinkingButton

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var button: JPShrinkingButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTableView()
        self.addButton()
    }

    override func prefersHomeIndicatorAutoHidden() -> Bool
    {
        return true
    }

    private func addTableView() {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }

    private func addButton() {
        let buttonHeight: CGFloat = 50.0
        let offSet: CGFloat = 16.0

        button = JPShrinkingButton(frame: CGRect(x: offSet, y: self.view.frame.size.height - buttonHeight - offSet, width: self.view.bounds.size.width - (2 * offSet), height: buttonHeight))
        button?.setTitle("Send Message", for: .normal)
        button?.setImage(#imageLiteral(resourceName: "message.png"), for: .normal)
        button?.tintColor = .white
        button?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button?.addTarget(self, action: #selector(showAlert), for: .touchUpInside)

        view.addSubview(button!)
    }

    @objc private func showAlert() {
        let alert = UIAlertController(title: "Hello world!", message: "What a cool button ??", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 35
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y >= 0.6 {
            button?.shrink()
            return
        }

        if velocity.y <= -0.6 {
            button?.expand()
            return
        }
    }
}

