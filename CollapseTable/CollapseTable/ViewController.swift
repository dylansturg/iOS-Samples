//
//  ViewController.swift
//  CollapseTable
//
//  Created by Dylan Sturgeon on 6/17/16.
//  Copyright © 2016 dylansturg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var collapseStatus = [Bool](count: 5, repeatedValue: false);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collapseStatus[section] ? 0 : 10;
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)";
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath);
        
        cell.textLabel!.text = "Cell: \(indexPath.row)";
        cell.detailTextLabel!.text = "Section: \(indexPath.section)";
        
        return cell;
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tag = section;
        
        var tapGestureAdded = false;
        
        if let gestures = view.gestureRecognizers {
            tapGestureAdded = gestures.contains({ (gesture) -> Bool in
                return gesture is UITapGestureRecognizer
            });
        }
        
        if !tapGestureAdded{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.sectionHeaderSelected(_:)));
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    func sectionHeaderSelected(sender: UITapGestureRecognizer!){
        let section = sender.view!.tag;
        
        toggleSectionState(section);
    }
    
    func toggleSectionState(section: Int){
        collapseStatus[section] = !collapseStatus[section];
        
        tableView.beginUpdates()
        
        let modifiedIndexPaths  = createIndexPathsForSection(section);
        if(collapseStatus[section]) {
            tableView.deleteRowsAtIndexPaths(modifiedIndexPaths, withRowAnimation: .Bottom);
        } else {
            tableView.insertRowsAtIndexPaths(modifiedIndexPaths, withRowAnimation: .Bottom);
        }
        
        tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // toggleSectionState(indexPath.section);
    }
    
    func createIndexPathsForSection(section: NSInteger) -> [NSIndexPath] {
        var result = [NSIndexPath]();
        for i in 0...9 {
            result.append(NSIndexPath(forRow: i, inSection: section));
        }
        return result;
    }
}

