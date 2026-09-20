# Тестирование

Проверяются paid/unpaid order, повтор order_id, valid/repeated activation, invalid certificate code и создание VineUpdates. Для каждого теста фиксируются execution ID, row count и status fields. Повторная доставка не должна создавать новый certificate code или вторую лозу.
