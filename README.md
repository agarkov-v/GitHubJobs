# Ios Jobs

- [Description in English](#Description-in-English)
  - [About the project](#About-the-project)
  - [Branches](#Branches)
- [Описание на русском](#Описание-на-русском)
  - [О проекте](#О-проекте)
  - [Ветки](#Ветки)

## Description in English

### About the project
**Ios Jobs** - this is a small and simple project that is a list of vacancies from the [API Github jobs](https://jobs.github.com/api), for the IOS mobile operating system.
**Features:** Displays a list of vacancies sorted by date, divided into sections, where the section title is the date and the cells are vacancies. It is also possible to view the selected vacancy in detail screen.
The CocoaPods dependency manager was used to install the dependencies. To install them use the command
```ruby
pod install
```
in the main project folder.
### Branches
There are 4 branches in the project:
- **master** - the RxNetworkApiClient branch is embedded in master
- **URLSession**
- **Alamofire**
- **RxNetworkApiClient**

The architecture used is - **Clean architecture + MVP**. Each branch uses a framework for working with the network that corresponds to the name of the branch.
## Описание на русском

### О проекте
**Ios Jobs** - маленький и просто проект, который представляет собой список вакансий из [API Github jobs](https://jobs.github.com/api), для мобильной ОС IOS.
**Возможности:** Выводит отсортированный по дате список вакансий, разделенный на секции, где заголовок секции - дата, а ячейки - вакансии. Так же имеется возможность детального просмотра выбранной вакансии.
Для установки зависимостей использовался менеджер зависимостей [CocoaPods](https://cocoapods.org). Чтобы установить их используйте команду
```ruby
pod install
```
в главной папке проекта.
### Ветки
В проекте присутствуют 4 ветки:
- **master** - в master влита ветка RxNetworkApiClient
- **URLSession**
- **Alamofire**
- **RxNetworkApiClient**

Используемая архитектура - **Clean architecture + MVP**. В каждой ветке для работы с сетью используется фреймворк, соответствующий названию ветки.
