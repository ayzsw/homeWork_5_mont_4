//
//  DataViewController.swift
//  home_work_5_mont_4
//
//  Created by Аяз on 2/6/23.
//

import UIKit

class DataViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private var data: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButton))
        updateUI()
        extensionUpdate()
        networking()
    }
    
    @objc func barButton() {
        
        let alertController = UIAlertController(title: "Добавить новый продукт", message: "Заполните все поля!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let id = alertController.textFields?.first?.text,let title = alertController.textFields?[1].text else{return}
            ApiManager.shared.postRequest(id: Int(id)!, title: title) { result in
                switch result {
                case .success(let code):
                    DispatchQueue.main.async {
                        self.showAlert(title: "Status code", message: "Your status code is: \(code)")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
        let action2 = UIAlertAction(title: "Назад", style: .cancel)
        
        alertController.addAction(action)
        alertController.addAction(action2)
        alertController.addTextField { tf in
            tf.placeholder = "ID"
        }
        alertController.addTextField { tf in
            tf.placeholder = "Name"
        }
        self.present(alertController, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func networking() {
        ApiManager.shared.getRequest { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.data = data.products
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func extensionUpdate() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func updateUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DataViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let model = data[indexPath.row]
        cell.updateInfo(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
