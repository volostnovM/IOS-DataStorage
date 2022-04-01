//
//  ViewController.swift
//  FileManager
//
//  Created by TIS Developer on 25.02.2022.
//

import UIKit

class FileManagerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var filesListArray: [String] = []
    let fileManager = FileManager.default
    
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Диспетчер файлов"
        //создать кнопку добавления картинок
        makeBarItems()
        setupConstraint()
        setuptableView()
        
        //показать все файлы из папки
        showFiles()
        getListFiles()
    }
    
    func showFiles() {

        do {
            let urlDocuments = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contents = try FileManager.default.contentsOfDirectory(at: urlDocuments, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            
            for file in contents {
                let filePath = file.path
                print("File path: \(filePath)")
            }
        }
        catch {
            print("Не удается найти заданную ссылку на файлы")
        }
    }

    func makeBarItems() {
        let buttonAdd = UIButton(type: .custom)
        buttonAdd.setTitle("Add", for: .normal)
        buttonAdd.setTitleColor(.black, for: .normal)
        buttonAdd.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        let itemButtonAdd = UIBarButtonItem(customView: buttonAdd)
        
        navigationItem.setRightBarButtonItems([itemButtonAdd], animated: true)
        
    }
    
    func setuptableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let result = image?.jpegData(compressionQuality:  1.0)
        saveImage(data: result)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImage(data: Data?) {
        do {
            let urlDocuments = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let result = formatter.string(from: date)
            
            let fileName = "image-\(result).jpg"
            let fileURL = urlDocuments.appendingPathComponent(fileName)
            
            if let data = data, !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try data.write(to: fileURL)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
            getListFiles()
            tableView.reloadData()
        }
        catch {
            print("Не удается найти указанную ссылку")
        }
    }
    
    func removeFile(name: String) {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(name) else { return }
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print(error)
        }
    }
    
    @objc func buttonAddTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension FileManagerViewController {
    func setupConstraint() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FileManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            removeFile(name: filesListArray.sorted()[indexPath.row])
            getListFiles()
            tableView.reloadData()
        }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FileManagerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = filesListArray.count
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)

        if UserDefaults.standard.bool(forKey: "sort") {
            cell.textLabel?.text = filesListArray.sorted(by: < )[indexPath.row]
        } else {
            cell.textLabel?.text = filesListArray.sorted(by: > )[indexPath.row]
        }
        
        return cell
    }
    
    func getFiles() -> [URL] {
        var urls: [URL]
        urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        do {
            urls = try fileManager.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
        } catch {
            print("Error while enumerating files: \(error.localizedDescription)")
        }
        return urls
    }
    
    func getListFiles() {

        filesListArray = []
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        print(url)
        let contents = try? fileManager.contentsOfDirectory(atPath: url.path)
        guard let contents = contents else { return }

        for file in contents {
            filesListArray.append(file)
        }
    }
}
