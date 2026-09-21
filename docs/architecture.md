# Архитектура

Два независимых TEST workflow используют общую PostgreSQL schema. Payment Processing создаёт заказ только после валидации, использует `order_id` как business idempotency key и сохраняет неизменяемый certificate code. Activation допускает только оплаченный и ещё не активированный code. Внешняя доставка расположена после commit бизнес-данных, поэтому ошибка email не теряет заказ.

Read-only Personal Vine Page работает в существующем n8n runtime: валидирует `certificate_code`, выполняет только SELECT из `vines` и `vine_updates`, отображает карточку лозы и возвращает 404 для неизвестного кода. Отдельный Database Evidence UI использует тот же read-only доступ для наглядного отображения строк таблиц.
