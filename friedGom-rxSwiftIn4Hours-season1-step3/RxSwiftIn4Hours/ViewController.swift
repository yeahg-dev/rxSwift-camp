//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
    }

    // MARK: - IBOutler

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var idValidView: UIView!
    @IBOutlet var pwValidView: UIView!

    let idInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let idValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    // MARK: - Bind UI
    // id input +--> check valid --> bullet
    //          |
    //          +--> button enable
    //          |
    // pw input +--> check valid --> bullet

    private func bindInput() {
       
        idField.rx.text.orEmpty
            .bind(to: idInputText)
            .disposed(by: disposeBag)
        
        idInputText.map(checkEmailValid)
            .bind(to: idValid)
            .disposed(by: disposeBag)
        
        pwField.rx.text.orEmpty
            .bind(to: pwInputText)
            .disposed(by: disposeBag)
        
        pwInputText.map(checkPasswordValid)
            .bind(to: pwValid)
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        idValid.subscribe { [weak self] result in
            self?.idValidView.isHidden = result
        }.disposed(by: disposeBag)
        
        pwValid.subscribe { [weak self] result in
            self?.pwValidView.isHidden = result
        }.disposed(by: disposeBag)
        
        Observable.combineLatest(idValid,
                                 pwValid,
                                 resultSelector: {$0 && $1})
        .subscribe (onNext: { [weak self] result in
            self?.loginButton.isEnabled = result})
        .disposed(by: disposeBag)
        
    }

    // MARK: - Logic

    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
}
