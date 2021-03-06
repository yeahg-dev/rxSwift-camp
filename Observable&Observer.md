# ๐ฃ Observable๊ณผ Observer : Basic

### ๐ง๐ปโโ๏ธ References
[ReactiveX : Observable](https://reactivex.io/documentation/observable.html)

<br>

> ๋ค์ด๊ฐ๊ธฐ์ , ๋์์ด ์ ๊น ๋ณด์ค๊ฒ์
> 
>`observable` =  `observable sequence` = `sequence`
>
>`Observer` = `reactor` = `watcher` = `subscriber`

<br>

### ์ ์ฌ์ฉํ ๊น?
๋น๋๊ธฐ ์์์ ๋ฆฌํด๊ฐ์ ๊ฐ๋์ฑ ์ข๊ฒ ์ฌ์ฉํ๋ ค๊ณ . 

์ ์ธํ์ผ๋ก ํธ๋ฆฌํ๊ฒ ์ฐ๋ ค๊ณ ! (์ญํ  ๋ถ๋ฆฌ์๋ ์ฉ์ด)

<br>

## 0. ๊ธฐ๋ณธ ๋งค์ปค๋์ฆ
Observer๋ Observable์ด ๋ฐฉ์ถํ๋ ์์ดํ์ด๋ ์์ดํ์ sequence์ ๋ฐ์ํ๋ค. 

๋์์ ์ธ ์์์ ์ ์ฉํ๊ฒ ํ๋๋ฐ, ์๋ํ๋ฉด Observable์ด ์์ดํ์ ๋ฐฉ์ถํ  ๋๊น์ง ์ค๋ ๋๋ฅผ ๋ธ๋ฝํ์ง ์๊ธฐ๋๋ฌธ์ด๋ค.  ๋์ ์ observer๋ผ๋ ๋ณด์ด๋ฅผ ์ธ์์ ๋๊ธฐํ๊ณ  ์๋ค๊ฐ ๋ฏธ๋์ Observable์ด ๋ฐฉ์ถํ  ๋ ๋ฐ์ํ๋๋ก ํ๋ค. 

1. ๋น๋๊ธฐ ํธ์ถ์ ์ํ **๋ฆฌํด ๊ฐ**์ ์ฌ์ฉํ  ๋ฉ์๋ ์ ์ โ `Observer` ์ ๋ฉ์๋
2. ๋น๋๊ธฐ ํธ์ถ์ `Observable` ๋ก ์ ์
3. `.subscribe` ๋ฅผ ํจ์ผ๋ก์ `Observable` ์ `Observer` ๋ถ์ฐฉ! + `Observable` ์ ์๋ ํธ๋ฆฌ๊ฑฐ
4. `Observable` ์ด ๋ฐฉ์ถํ๋ ์์ดํ์ผ๋ก `Observer` ๋ ์ผ ์ฒ๋ฆฌ

**Observable๋ก ๋น๋๊ธฐ ์์์ ์ ์, `subscribe` ์ ํธ์ถํจ์ผ๋ก์จ ์์์ trigger, ๋น๋๊ธฐ ๋ฆฌํด๊ฐ์ ์๋น**

<br>
๐ ๋ธํฐํผ์ผ์ด์์ ์๋ก ์ฃผ๊ณ  ๋ฐ์ผ๋ฉฐ, ๋ธํฐํผ์ผ์ด์์ ๋ํ ํธ๋ค๋ฌ๋ฅผ ๊ตฌํํจ์ผ๋ก์จ ๋ฐ์

### Observable์ด Observer์ ์ํตํ๋ ๋ฐฉ๋ฒ, Notification

[https://reactivex.io/documentation/contract.html](https://reactivex.io/documentation/contract.html)

- `onNext`
    
    Observable์ ์ํด ๋ฐฉ์ถ๋ ์์ดํ์ **Observer์๊ฒ ์ ๋ฌ**
    
    ํ๋์ `onNext` ๋ single emitted item์ ํํ
    
- `onCompleted`
    
    Observable์ด ์ฑ๊ณต์ ์ผ๋ก ์๋ฃํ๋ค๋ ์๋ฏธ, ๋ ์ด์ ์์ดํ์ ๋ฐฉ์ถํ์ง ์์
    
- `onError`
    
    Observable์ด ์ด๋ ํ ์๋ฌ๋๋ฌธ์ ์ข๋ฃํ๊ณ , ๋ ์ด์ ์์ดํ์ ๋ฐฉ์ถํ์ง ์์ ๊ฒ์ด๋ผ๋ ์๋ฏธ
    
- `onSubscribe` (optional)
    
    Observable์ด observer์๊ฒ `request` ๋ฅผ ๋ฐ์ ์ค๋น๊ฐ ๋์๋ค๋ ์๋ฏธ
    


### Observer๊ฐ Observable๊ณผ ์ํตํ๋ ๋ฐฉ๋ฒ, Notification

- **`Subscribe`**
    
    Observer๊ฐ Observable๋ก ๋ถํฐ ๋ธํฐํผ์ผ์ด์์ ๋ฐ์ ์ค๋น๊ฐ ๋์ด์๋ค๋ ์๋ฏธ
    
    `onNext` `onCompleted` `onError` 3๊ฐ์ง ๋ฉ์๋๋ฅผ ๋ฐ๊ฑฐ๋ ์ด 3๊ฐ์ง ๋ฉ์๋๋ฅผ ์ง์ํ๋ ๊ฐ์ฒด๋ฅผ ๋ฐ์
    
- **`Unsubscribe`**
    
    Obseerver๊ฐ ๋ ์ด์ Observable๋ก ๋ถํฐ ๋ธํฐํผ์ผ์ด์์ ๋ฐ์ง ์๊ฒ ๋ค๋ ์๋ฏธ
    
- **`Request` (optional)**
    
    Observer๊ฐ Observable๋ก๋ถํฐ ํน์  ์ ์ด์์ OnNext ์๋ฆผ์ ์ํ์ง ์์์ ์๋ฏธ
    

### Observer๊ฐ ๊ตฌํํ๋ ๋ฉ์๋๋ค

- `onNext`
    
    `Observable` ์ด ์์ดํ์ ๋ฐฉ์ถํ์ ๋ ํธ์ถ. `Observable` ์ ์ํด ๋ฐฉ์ถ๋ ์์ดํ์ ๋ฉ์๋์ ํ๋ผ๋ฏธํฐ๋ก ์ฌ์ฉ
    
- `onError`
    
    ๋ฐ๊ธฐ๋กํ ๋ฐ์ดํฐ๋ฅผ ์์ฑํ์ง ๋ชปํ๊ฑฐ๋, ์๋ฌ๋ฅผ ๋ง์ฃผ์ณค์ ๋ `Observable` ์ด ํธ์ถ. ๋์ด์์ `onNext` ๋ `onCompleted` ๋ฅผ ํธ์ถํ์ง ์์. ๋ฌด์์ด ์๋ฌ๋ฅผ ๋ฐ์์์ผฐ๋์ง ์์ธ์ ๋ฉ์๋์ ํ๋ผ๋ฏธํฐ๋ก ์ฌ์ฉ
    
- `onCompleted`
    
    `Observable` ์ด ๋ง์ง๋ง `onNext` ๋ฅผ ํธ์ถํ ํ `onCompleted` ๋ฅผ ํธ์ถ. ์๋ฌ๋ฅผ ๋ง์ฃผํ์ง ์์ ๊ฒฝ์ฐ
    
<br>

## 1. Observable์ ํ์

`just` ์ธ์๋ `of`, `from` ๋ฑ  ๋ค์ํ ์์ฑ operator๊ฐ ์กด์ฌํ๋ค โฌ๏ธ

[https://reactivex.io/documentation/operators.html#creating](https://reactivex.io/documentation/operators.html#creating)

### `just`

ํ๋ผ๋ฏธํฐ๋ก ์ ๋ฌํ ํ๋์ ์์ดํ์ ๋ฐฉ์ถํ๋ observable ์์ฑ

`next`์ ์์ดํ์ ์ค์ด์ ๋ฐฉ์ถ

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

## 2. Obeservable์ ๋

Observable์ด `onCompleted` ๋ `onError` ๋ฅผ ๋ฐํํ๋ฉด, Obesrvable์ด ์์์ ํด์ ํ๊ณ  ์ข๋ฃํ๋ค. ๊ทธ๋ฌ๋ฉด observer๋ ๋ ์ด์ observable์ด๋ ์ํตํ๋ ค๊ณ  ํ์ง ์๋๋ค. 



### `dispose()`

`dispose()` ํธ์ถํ๋ฉด ๊ตฌ๋์ด ์ทจ์๋จ. ์ด๋ฒคํธ ๋ฐฉ์ถ์ด ์ ์ง๋๋ค.

<br>

## 3. subscribe ํ๋ ๋ค์ํ ๋ฐฉ๋ฒ

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

`onNext` ๋ง ํธ๋ค๋ง

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


## 4. Observable : hot ๐ย cold

- cold : observer๊ฐ subscribeํ๊ธฐ ์  ๊น์ง ์์ดํ์ ๋ฐฉ์ถํ์ง ์๋ observable
- hot : subscribe์ ์๊ด์์ด ์ธ์ ๋ ์์ดํ์ ๋ฐฉ์ถํ๊ณ  ์๋ observable. observer๊ฐ ๊ตฌ๋์ ํ๋ฉด ๋ฐฉ์ถ์ด ์ฒ์ ์์๋ ์ดํ์ ๋ฐฉ์ถ๋๋ ์์ดํ(๊ตฌ๋ํ๋ ์์ ๋ถํฐ ๋ฐฉ์ถ๋๋ ์์ดํ)์ ๊ด์ฐฐ. ๊ทธ๋์ observer๋ ๋ฐฉ์ถ์ด ์์ํ ๋ค๋ถํฐ ๊ตฌ๋ ์ ๊น์ง ๋ฐฉ์ถํ ์์ดํ์ ๋์นจ

<br>

## 5. Backpressure

backpressure๋ ์ ํ (๋ชจ๋  observable๊ณผ operator๊ฐ ์ง์ํ๋ ๊ฒ์ ์๋)

observer๊ฐ `request` notification์ ๊ตฌํํ๊ณ  `onSubscribe` ๋ธํฐํผ์ผ์ด์์ ์ดํดํ  ๋๋ง, observable์ด backpresure๋ฅผ ๊ตฌํํจ

๋ง์ฝ observable์ด ๋ฐฐ์์ ๊ตฌํํ๊ณ , observer๊ฐ ๋ฐฐ์์ ์ฑ์ฉํ๋ฉด obserable์ ๋ ์ด์ ์์ดํ์ ๋ฐฉ์ถํ์ง ์๊ณ , observer์๊ฒ `onSubscribe` ๋ฅผ ๋ณด๋ธ๋ค. observer๋ ๋ฐ์ผ๋ฉด observable์๊ฒ `request` ๋ฅผ ๋ณด๋ธ๋ค. `request` ๋ ํน์  ๊ฐ์์ ์์ดํ๋ง ๋ฐฉ์ถํ๊ธธ ์ํ๋ค๋ ๊ฒ์ผ๋ก observable์ด ํน์  ๊ฐ์ ์๋๋ก๋ง ์์ดํ์ ๋ฐฉ์ถํ๋ค. However the Observable may, in addition, issue an OnCompleted or OnError notification, and it may even issue such a notification before the observer requests any items at all.

observable์ด ๋ฐฐ์์ ๊ตฌํํ์ง ์์๋๋ฐ, `request` ๋ฅผ ๋ฐ์ผ๋ฉด ๋ฐฐ์์ ์ง์ํ์ง ์๋๋ค๋ `onError` ๋ฅผ ๋ฐํํ๋ค.

<br>

## 6. Unsubscribe


`Subscriber` ๋ผ๋ ํน๋ณํ observer ์ธํฐํ์ด์ค๊ฐ ์กด์ฌํ๋๋ฐ, `unsubscribe` ๋ฉ์๋๋ฅผ ๊ตฌํํ๋ค. `unsubscribe` ์ ํธ์ถํ๋ฉด, ๊ตฌ๋๋นํ๊ณ  ์๋ observable์ ๋ค๋ฅธ observer๊ฐ ์๋ค๋ฉด ์๋ก์ด ์์ดํ์ ๋ฐฉ์ถํ๋ ๊ฒ์ ๋ฉ์ถ๋ค. 

๊ทธ๋ฐ๋ฐ ๋ฐ๋ก ๋ฐฉ์ถ์ ๋ฉ์ถฐ๋ฒ๋ฆฌ๋ ๊ฒ์ ์๋๊ณ ,,

- ๋น๋๊ธฐ์ 
- ์ด๋ฒคํธ๋ฅผ ์์ฑ = emitting(๋ฐฉ์ถ)

- Observable์ด `next` ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ๋ฉด, ๊ณ์ํด์ ์ด๋ฒคํธ๋ฅผ ์งํํ  ์ ์์
- `error` ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ์ฌ ์์  ์ข๋ฃ๋  ์ ์์
- `complete` ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ์ฌ ์์  ์ข๋ฃ๋  ์ ์์

<br>

## 7. Dispose

### `Disposable`

Observableํ์์ ๋ชจ๋ Disposableํ์์ ๋ฐํ

### `DisposeBag` = ์ฐ๋ ๊ธฐํต

Disposable ๋ณ์๋ค์ ๋ด์๋์๋ค๊ฐ ํ๋ฒ์ ์ข๋ฃํ๊ณ  ์์์ ์ข๋ฃ์ํฌ ๋ ์ฌ์ฉ

disposeBag์ด ๋ฉ๋ชจ๋ฆฌ ํด์ (?)๋  ๋ disposable์ `dispose()` ํธ์ถ

UI์ ๊ฒฝ์ฐ ViewController๊ฐ ํ๋ฉด์ ๋ณด์ฌ์ง๋ ๋์์๋ ์คํธ๋ฆผ์ด ์ข๋ฃ๋๋ฉด ์๋จ. ์ด๋ฒคํธ๋ฅผ ๊ด์ฐฐํ์ฌ์ผํจ. ๊ทธ๋์ DisposeBag์ ๋ด์๋ .

