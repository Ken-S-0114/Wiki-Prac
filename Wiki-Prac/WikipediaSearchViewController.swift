//
//  WikipediaSearchViewController.swift
//  Wiki-Prac
//
//  Created by 佐藤賢 on 2019/06/08.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class WikipediaSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = WikipediaSearchViewModel(
            searchWord: searchBar.rx.text.orEmpty.asObservable(),
            wikipediaAPI: WikipediaDefaultAPI(URLSession: .shared)
        )

        viewModel.wikipediaPages
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, result, cell in
                cell.textLabel?.text = result.title
                cell.detailTextLabel?.text = result.url.absoluteString
        }
        .disposed(by: disposeBag)
    }
    
}
