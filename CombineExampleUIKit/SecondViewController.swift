//
//  SecondViewController.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 06/07/2022.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @Published var firstText: String?
    @Published var secondText: String?
    
    var nofificationCenter = NotificationCenter.default
    var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublisher()
        
    }
    
    func setupPublisher() {
        
        let publisher = nofificationCenter.publisher(for: UITextField.textDidChangeNotification, object: firstTextField)
        publisher.sink { _ in
            
        } receiveValue: { textField in
            guard let textField = textField.object as? UITextField else {
                return
            }
            let text = textField.text
            self.firstText = text
        }.store(in: &subscribers)
        
        let publisherSecond = nofificationCenter.publisher(for: UITextField.textDidChangeNotification, object: secondTextField)
        publisherSecond.sink { _ in
            
        } receiveValue: { textField in
            guard let textField = textField.object as? UITextField else {
                return
            }
            let text = textField.text
            self.secondText = text
        }.store(in: &subscribers)

        //обьединение двух publishers
        Publishers.CombineLatest($firstText, $secondText).sink { _ in
            
        } receiveValue: { [weak self] first, second in
            guard let first = self?.firstText,
            let second = self?.secondText
            else { return }
            
            self?.label.text = first + second
        }.store(in: &subscribers)
    }
}
