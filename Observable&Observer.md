# 🐣 Observable과 Observer : Basic

### 🧚🏻‍♀️ References
[ReactiveX : Observable](https://reactivex.io/documentation/observable.html)

<br>

> 들어가기전, 동의어 잠깐 보실게요
> 
>`observable` =  `observable sequence` = `sequence`
>
>`Observer` = `reactor` = `watcher` = `subscriber`

<br>

### 왜 사용할까?
비동기 작업의 리턴값을 가독성 좋게 사용하려고. 

선언형으로 편리하게 쓰려고! (역할 분리에도 용이)

<br>

## 0. 기본 매커니즘
Observer는 Observable이 방출하는 아이템이나 아이템의 sequence에 반응한다. 

동시적인 작업을 유용하게 하는데, 왜냐하면 Observable이 아이템을 방출할 때까지 스레드를 블락하지 않기때문이다.  대신에 observer라는 보초를 세워서 대기타고 있다가 미래에 Observable이 방출할 때 반응하도록 한다. 

1. 비동기 호출에 의한 **리턴 값**을 사용할 메서드 정의 → `Observer` 의 메서드
2. 비동기 호출을 `Observable` 로 정의
3. `.subscribe` 를 함으로서 `Observable` 에 `Observer` 부착! + `Observable` 의 작동 트리거
4. `Observable` 이 방출하는 아이템으로 `Observer` 는 일 처리

**Observable로 비동기 작업을 정의, `subscribe` 을 호출함으로써 작업을 trigger, 비동기 리턴값을 소비**

<br>
💌 노티피케이션을 서로 주고 받으며, 노티피케이션에 대한 핸들러를 구현함으로써 반응

### Observable이 Observer와 소통하는 방법, Notification

[https://reactivex.io/documentation/contract.html](https://reactivex.io/documentation/contract.html)

- `onNext`
    
    Observable에 의해 방출된 아이템을 **Observer에게 전달**
    
    하나의 `onNext` 는 single emitted item을 표현
    
- `onCompleted`
    
    Observable이 성공적으로 완료했다는 의미, 더 이상 아이템을 방출하지 않음
    
- `onError`
    
    Observable이 어떠한 에러때문에 종료했고, 더 이상 아이템을 방출하지 않을 것이라는 의미
    
- `onSubscribe` (optional)
    
    Observable이 observer에게 `request` 를 받을 준비가 되엇다는 의미
    


### Observer가 Observable과 소통하는 방법, Notification

- **`Subscribe`**
    
    Observer가 Observable로 부터 노티피케이션을 받을 준비가 되어있다는 의미
    
    `onNext` `onCompleted` `onError` 3가지 메서드를 받거나 이 3가지 메서드를 지원하는 객체를 받음
    
- **`Unsubscribe`**
    
    Obseerver가 더 이상 Observable로 부터 노티피케이션을 받지 않겠다는 의미
    
- **`Request` (optional)**
    
    Observer가 Observable로부터 특정 수 이상의 OnNext 알림을 원하지 않음을 의미
    

### Observer가 구현하는 메서드들

- `onNext`
    
    `Observable` 이 아이템을 방출했을 때 호출. `Observable` 에 의해 방출된 아이템을 메서드의 파라미터로 사용
    
- `onError`
    
    받기로한 데이터를 생성하지 못했거나, 에러를 마주쳤을 때 `Observable` 이 호출. 더이상의 `onNext` 나 `onCompleted` 를 호출하지 않음. 무엇이 에러를 발생시켰는지 원인을 메서드의 파라미터로 사용
    
- `onCompleted`
    
    `Observable` 이 마지막 `onNext` 를 호출한 후 `onCompleted` 를 호출. 에러를 마주하지 않은 경우
    
<br>

## 1. Observable의 탄생

`just` 외에도 `of`, `from` 등  다양한 생성 operator가 존재한다 ⬇️

[https://reactivex.io/documentation/operators.html#creating](https://reactivex.io/documentation/operators.html#creating)

### `just`

파라미터로 전달한 하나의 아이템을 방출하는 observable 생성

`next`에 아이템을 실어서 방출

```swift
let source = Observable.just(1, 2, 3)

source.subscribe {
    print($0)
}
// next((1, 2, 3))
// completed

let source2 = Observable.just([1,2,3])

source2.subscribe {
    print($0)
}
// next([1, 2, 3])
// completed
```

<br>

## 2. Obeservable의 끝

Observable이 `onCompleted` 나 `onError` 를 발행하면, Obesrvable이 자원을 해제하고 종료한다. 그러면 observer는 더 이상 observable이랑 소통하려고 하지 않는다. 



### `dispose()`

`dispose()` 호출하면 구독이 취소됨. 이벤트 방출이 정지된다.

<br>

## 3. subscribe 하는 다양한 방법

### 1. `subscribe()`

```swift
let observable = Observable.of(1, 2, 3)
observable.subscribe({ (event) in
	 print(event)
})
 	
 	/* Prints:
 	 next(1)
 	 next(2)
 	 next(3)
 	 completed
 	*/
 }
```

### 2. `subscribe(onNext:)`

`onNext` 만 핸들링

```swift
observable.subscribe(onNext: { (element) in
 	print(element)
 })
 
 /* Prints:
  1
  2
  3
 */
```

<br>


## 4. Observable : hot 🆚 cold

- cold : observer가 subscribe하기 전 까진 아이템을 방출하지 않는 observable
- hot : subscribe에 상관없이 언제나 아이템을 방출하고 있는 observable. observer가 구독을 하면 방출이 처음 시작된 이후에 방출되는 아이템(구독하는 시점부터 방출되는 아이템)을 관찰. 그래서 observer는 방출이 시작한 뒤부터 구독 전까지 방출한 아이템은 놓침

<br>

## 5. Backpressure

backpressure는 선택 (모든 observable과 operator가 지원하는 것은 아님)

observer가 `request` notification을 구현하고 `onSubscribe` 노티피케이션을 이해할 때만, observable이 backpresure를 구현함

만약 observable이 배압을 구현하고, observer가 배압을 채용하면 obserable은 더 이상 아이템을 방출하지 않고, observer에게 `onSubscribe` 를 보낸다. observer는 받으면 observable에게 `request` 를 보낸다. `request` 는 특정 개수의 아이템만 방출하길 원한다는 것으로 observable이 특정 개수 아래로만 아이템을 방출한다. However the Observable may, in addition, issue an OnCompleted or OnError notification, and it may even issue such a notification before the observer requests any items at all.

observable이 배압을 구현하지 않았는데, `request` 를 받으면 배압을 지원하지 않는다는 `onError` 를 발행한다.

<br>

## 6. Unsubscribe


`Subscriber` 라는 특별한 observer 인터페이스가 존재하는데, `unsubscribe` 메서드를 구현한다. `unsubscribe` 을 호출하면, 구독당하고 있던 observable은 다른 observer가 없다면 새로운 아이템을 방출하는 것을 멈춘다. 

그런데 바로 방출을 멈춰버리는 것은 아니고,,

- 비동기적
- 이벤트를 생성 = emitting(방출)

- Observable이 `next` 이벤트를 방출하면, 계속해서 이벤트를 진행할 수 있음
- `error` 이벤트를 방출하여 완전 종료될 수 있음
- `complete` 이벤트를 방출하여 완전 종료될 수 있음

<br>

## 7. Dispose

### `Disposable`

Observable타입은 모두 Disposable타입을 반환

### `DisposeBag` = 쓰레기통

Disposable 변수들을 담아두었다가 한번에 종료하고 작업을 종료시킬 때 사용

disposeBag이 메모리 해제(?)될 때 disposable의 `dispose()` 호출

UI의 경우 ViewController가 화면에 보여지는 동안에는 스트림이 종료되면 안됨. 이벤트를 관찰하여야함. 그래서 DisposeBag에 담아둠.

