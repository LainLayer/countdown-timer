# Countdown Timer

A simple and tiny timer that counts down in big figlet numbers. \
Made for personal use, do whatever you want with this.

## Build

``` sh
nim c -d:release -d:danger -d:lto --gc:arc --opt:size countdown.nim && strip -s countdown
```
