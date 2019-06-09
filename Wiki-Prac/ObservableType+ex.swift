//
//  ObservableType+ex.swift
//  Wiki-Prac
//
//  Created by 佐藤賢 on 2019/06/09.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import RxSwift

extension ObservableType where E: EventConvertible {
    public func elements() -> Observable<E.ElementType> {
        return filter { $0.event.element != nil }.map { $0.event.element! }
    }

    public func errors() -> Observable<Swift.Error> {
        return filter { $0.event.error != nil }.map { $0.event.error! }
    }
}
