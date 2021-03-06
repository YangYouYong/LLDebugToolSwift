//
//  TestCrashViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by Li on 2018/9/13.
//

import UIKit
import LLDebugTool

class TestCrashViewController: BaseTestViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.crash", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if (indexPath.row == 0) {
            cell.textLabel?.text = NSLocalizedString("try.array.crash", comment: "");
            cell.detailTextLabel?.text = NSLocalizedString("crash.info", comment: "");
        } else if (indexPath.row == 1) {
            cell.textLabel?.text = NSLocalizedString("try.pointer.crash", comment: "");
            cell.detailTextLabel?.text = NSLocalizedString("crash.info", comment: "");
        } else if (indexPath.row == 2) {
            cell.textLabel?.text = NSLocalizedString("try.signal", comment: "");
            cell.detailTextLabel?.text = NSLocalizedString("signal.info", comment: "");
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.testArrayOutRangeCrash()
        } else if (indexPath.row == 1) {
            self.testPointErrorCrash()
        } else if (indexPath.row == 2) {
            self.testSignalCrash()
        }
        tableView.reloadData()
    }
    
    // MARK: - ACTIONS
    func testArrayOutRangeCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        let array = ["a" , "b"]
        _ = array[3]
    }
    
    func testPointErrorCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        let a : NSObject = "dssdf" as NSObject
        _ = (a as! NSArray).firstObject
    }
    
    func testSignalCrash() {
        UserDefaults.standard.set(true, forKey: "openCrash")
        UserDefaults.standard.synchronize()
        kill(0, SIGTRAP)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            LLDebugTool.shared().showDebugViewController(with: 2)
            UserDefaults.standard.set(false, forKey: "openCrash")
            UserDefaults.standard.synchronize()
        }
    }

}
