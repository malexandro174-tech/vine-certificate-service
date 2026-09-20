# Архитектура

Два независимых TEST workflow используют общую PostgreSQL schema. Payment Processing создаёт заказ только после валидации, использует `order_id` как business idempotency key и сохраняет неизменяемый certificate code. Activation допускает только оплаченный и ещё не активированный code. Внешняя доставка расположена после commit бизнес-данных, поэтому ошибка email не теряет заказ.
