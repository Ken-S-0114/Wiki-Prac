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
    let error: Observable<Error>

    init(searchWord: Observable<String>, wikipediaAPI: WikipediaAPI) {
        let sequence = searchWord
            .filter { 3 <= $0.count }
            .flatMapLatest {
                return wikipediaAPI.search(from: $0).materialize()
        }
        .share(replay: 1)

        wikipediaPages = sequence.elements()
        error = sequence.errors()
    }
}
