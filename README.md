# busyboxをscoopで取得するためのjsonを配置するリポジトリ

下記のコマンドで <https://frippery.org/files/busybox/> から最新の実行ファイルを取得できる。  
GitHub Actions によって1日1回更新チェックされる。  

```sh
scoop install https://raw.githubusercontent.com/xcd0/busybox-w32/main/busybox.json
```

```sh
scoop install https://raw.githubusercontent.com/xcd0/busybox-w32/main/busybox64.json
```

```sh
scoop install https://raw.githubusercontent.com/xcd0/busybox-w32/main/busybox64u.json
```

## 背景

前提として、下記のコマンドでインストールできる。  
```sh
scoop install busybox
``` 

しかし、この場合、`busybox --install` 相当のことが実行されてしまい、`find`コマンド等それなりに副作用がある。  
これを避けるために作成した。  
本リポジトリのjsonの場合、ただbusyboxを配置するだけなので、前述の副作用は発生しない。  
