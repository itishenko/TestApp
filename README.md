# Test App
Простое iOS приложение с TabBar контроллером, где на первой вкладке находится локальная таблица редактируемых пунктов, а на второй - список данных полученных из сетевого запроса в XML формате.

Реализовано полностью без использования сторонних библиотек. Для хранения используется Core Data, для сетевых запросов URLSession и XMLParser для разбора ответа.

# Архитектура
Архитектура VIPER/Clean Swift с отдельно выделенными слоями приложения:

* App
* VIPER Modules: Main, List, Item, Service
* Common, Persistence, Networking
* Core (Models)

# Кодогенерация
Для кодогенерации базовой структуры VIPER модулей используется [Generamba](https://github.com/strongself/Generamba) и модифицированный шаблон [swifty_viper](https://github.com/strongself/generamba-catalog)
