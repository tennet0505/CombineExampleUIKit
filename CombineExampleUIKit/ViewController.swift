//
//  ViewController.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 27/06/2022.
//

import UIKit
import Combine

enum State {
    case failure
    case success
}

extension State {
    var colorRepresentation: UIColor  {
        switch self {
        case .failure:
            return .red
        case .success:
            return .green
        }
    }
}

extension Notification.Name {
    static let nameNotification = Notification.Name(rawValue: "NameNotification")
}

class ViewController: UIViewController {

    @Published var isEnableButton: Bool = false
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button2: UIButton!
    var state: State = .success {
        didSet {
            NotificationCenter.default.post(name: .nameNotification, object: state)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublisherAndSuscriber()
        
    }
    
    func setupPublisherAndSuscriber() {
        
        let publisher = NotificationCenter.Publisher(center: .default, name: .nameNotification, object: nil)
            .map{ ($0.object as? State)?.colorRepresentation }
        let subscriber = Subscribers.Assign(object: view, keyPath: \.backgroundColor)
        
        publisher.subscribe(subscriber)
        
//        let publisher = NotificationCenter.Publisher(center: .default, name: .nameNotification , object: nil)
//            .map { notification -> UIColor? in
//                (notification.object as? State)?.colorRepresentation ?? .red
//            }
//        let subscriber = Subscribers.Assign(object: label, keyPath: \.textColor)
//
//        publisher.subscribe(subscriber)
        
    }
    

    @IBAction func switcher(_ sender: UISwitch) {
        
        state =  sender.isOn ? .success : .failure
        
    }
}

