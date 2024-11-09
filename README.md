# Тестовое задание в компанию Индорс Навигейшн

### Установка
`git clone https://github.com/AlexanderPleshakov/TransportSchedules_Swift.git`

### Описание работы

Архитектура: MVP

В проекте есть 4 основных директории:
- App - файлы AppDelegate и SceneDelegate
- Scenes - содержит все экраны: ChooseRoute, Search, Result
- Services - содержит основную бизнеслогику приложения
- Resources - пакпа ресурсов

Разберём папку Services:
ModulesAssembly обеспечивает сборку каждого из экранов. 
DefaultStationsStorage получает из сети список всех станций и публикует уведомление
о их получении. Так как станций много и JSON файл довольно большой, запрос к api
 отправляется сразу после запуска приложения в AppDelegate.
ResultsService получает список маршрутов по заданным параметрам: откуда, куда, дата, траспорт.
В папке Network содежится NetworkClient и другие вспомогательные сущности для 
отправки сетевых запросов

Разберём папку Scenes:
Для каждого экрана своя папка, в которой содержутся подпапки Models, Views, Protocols
 и файлы ViewController'а и Presenter'а.


