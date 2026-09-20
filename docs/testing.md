# Тестирование

Проверяются paid/unpaid order, повтор order_id, valid/repeated activation, invalid certificate code, создание VineUpdates и изолированная SMTP delivery-проверка. Для каждого теста фиксируются execution ID, row count и status fields. Повторная доставка не должна создавать новый certificate code или вторую лозу.

Последняя SMTP-проверка: execution `31455`, `Succeeded`; используется отдельный TEST credential и self-send в аутентифицированный ящик. Адрес и credential values не включаются в репозиторий.
