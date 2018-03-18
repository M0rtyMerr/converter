# Currency Converter
[![Build Status](https://travis-ci.org/MortMerr/converter.svg?branch=develop)](https://travis-ci.org/MortMerr/converter)
App that converts between two currencies.

## Installation
Simply run `pod install` and press Run button.

## To Reviewers
Приложение работает с Fixer API, указанном в тестовом задании. К сожалению, бесплатно Fixer предоставляет только список валют, а за все остальные интересности (или хотя бы за https) требует 10 долларов.

Однако, суть задания от этого не меняется. Архитектура была описана мною так, как если бы у меня было 10 долларов на расширенное API, данные в одном месте замокированы,
соотвествующий комментарий подчеркивает это.

Понятно, что приложение для вывода результата двух запросов может быть описано гораздо проще, однако мной было решено продемонстрировать то, как бы я писал писал это для более крупного проекта.
А именно:

- CocoaPods
- Dependency Injection
- MVP
- RxSwift & RxCocoa & Rx extensions
- Quick/Nibmle for more declarative unit tests
- UI-tests
- Travis-CI
- Swiftlint
