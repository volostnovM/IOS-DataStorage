//
//  ViewController.swift
//  FileManager
//
//  Created by TIS Developer on 25.02.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    var imagePicker = UIImagePickerController()

    let fileManager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Диспетчер файлов"
        //создать кнопку добавления картинок
        makeBarItems()
        setupConstraint()
        setuptableView()
        
        //показать все файлы из папки
        showFiles()
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
        //tableView.allowsSelection = false
    }

    @objc func buttonAddTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
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
            tableView.reloadData()
        }
        catch {
            print("Не удается найти указанную ссылку")
        }
    }
}

extension ViewController {
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("delete")
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            //self.Items.remove(at: indexPath.row)
            
            var allFileInDirectory = self.getFiles()
            let directoryUrl = allFileInDirectory[indexPath.row]
            print("File for delete \(directoryUrl)")
            allFileInDirectory.remove(at: indexPath.row)
            
            do {
                try self.fileManager.removeItem(at: directoryUrl)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            catch {
                print("Не удалось найти файл для удаления")
            }
            
            complete(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = getFiles().count
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        let row = getFiles()[indexPath.row].path
        cell.textLabel?.text = (row as NSString).lastPathComponent
        return cell
    }
    
    func getFiles() -> [URL] {
        var urls: [URL]
        urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        do {
            urls = try fileManager.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
            //print("fileURLsCount: \(urls)")
        } catch {
            print("Error while enumerating files: \(error.localizedDescription)")
        }
        return urls
    }
}
