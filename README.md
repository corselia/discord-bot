# Overviews
- `Discord` bot by `Ruby`

# Installation
```bash
$ bundle install --path vendor/bundle
```

# Preparation
- set your environment values in `.env`

```.env
TOKEN="foooooooooooooooooooooooooooooo"
CLIENT_ID=12345678901234567890
PREFIX="!"
```

# Execution
```bash
$ bundle exec foreman start
```

# Example
```
[say]
!weather

[response]
東日本は高気圧に覆われています。一方東シナ海には、低気圧があって東
に進んでいます。

【関東甲信地方】
 関東甲信地方はおおむね晴れています。

 16日は、高気圧に覆われて晴れますが、上空の気圧の谷の影響で、次第
に曇りとなるでしょう。長野県の山沿いでは夜遅くに雨や雪の降る所がある
見込みです。

 17日は、東シナ海にある低気圧が、日本付近を発達しながら通過するた
め、曇りで次第に雨となるでしょう。伊豆諸島では雷を伴う所がある見込み
です。

 関東近海では、16日は波がやや高く、17日は波が高いでしょう。船舶
は高波に注意してください。

【東京地方】
 16日は、晴れで夜遅くは曇りとなるでしょう。
 17日は、曇りで昼過ぎから雨となる見込みです。
明日（2018-01-18）の東京都の天気は晴時々曇です。
最低気温は不明度、最高気温は不明度です。
```

# LICENSE
[MIT LICENSE](LICENSE)
