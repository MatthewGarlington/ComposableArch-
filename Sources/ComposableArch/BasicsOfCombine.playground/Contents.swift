import Foundation
import Combine

//var count = 0
//let iterator = AnyIterator<Int>.init {
//    count += 1
//    return count
//}
//
//Array(iterator.prefix(10))


let aFutureInt = Deferred {
    Future<Int, Never> { callback in
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            print("Hello from the future")
            callback(.success(42))
        }
    }
}

//aFutureInt.subscribe(AnySubscriber<Int, Never>.init(
//    receiveSubscription: { subscription in
//        print("Subscription")
//        subscription.request(.unlimited)
//    },
//    receiveValue: { value -> Subscribers.Demand in
//        print("Value")
//        print(value)
//        return .unlimited
//    },
//    receiveCompletion: { completeion in
//        print("Completion", completeion)
//    }))


let cancellable = aFutureInt.sink { int in
    print(int)
}

let passThrough = PassthroughSubject<Int, Never>.init()
let currentVakue = CurrentValueSubject<Int, Never>(2)

let c1 = passThrough.sink { x in
    print("Passthrough", x)
}

let c2 = currentVakue.sink { x in
    print("Current Value", x)
}

passThrough.send(42)
currentVakue.send(1729)
