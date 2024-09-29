# Тестовое задание в компанию Индорс Навигейшн

### Установка
`git clone https://github.com/AlexanderPleshakov/TransportSchedules_Swift.git`

### Результат

<p align="center">
  <img width="294" height="639" src="https://github.com/AlexanderPleshakov/my-assets/blob/main/indoors-task-design.png">
</p>

### Описание работы

Архитектура: MVP

В проекта есть 4 основных директории:
- App - файлы AppDelegate и SceneDelegate
- Scenes - содержит все экраны: ChooseRoute, Search, Result
- Services - содеждит основную бизнеслогику приложения
- Resources - пакпа ресурсов

Разберем папку Services:
ModulesAssembly обеспечивает сборку каждого из экранов. 
DefaultStationsStorage получает из сети список всех станций и публикует уведомление
о их получении. Так как станций много и JSON файл довольно большой, запрос к api
 отправляется сразу после запуска приложения.
ResultsService получает список маршрутов по заданным параметрам: откуда, куда, дата, траспорт.
В папке Network содежится NetworkClient и другие вспомогательные сущности для 
отправки сетевых запросов

Разберем папку Scenes:
Для каждого экрана своя папка, в которой содержутся подпапки Models, Views, Protocols
 и файлы ViewController'а и Presenter'а.


