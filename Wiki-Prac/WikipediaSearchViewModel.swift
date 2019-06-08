//
//  WikipediaSearchViewModel.swift
//  Wiki-Prac
//
//  Created by 佐藤賢 on 2019/06/08.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import RxSwift
import RxCocoa

class WikipediaSearchViewModel {
    let wikipediaPages: Observable<[WikipediaPage]>

    init(searchWord: Observable<String>, wikipediaAPI: WikipediaAPI) {
        wikipediaPages = searchWord
            .filter { 3 <= $0.count }
            .flatMapLatest {
                return wikipediaAPI.search(from: $0)
        }
        .share(replay: 1)
    }
}
