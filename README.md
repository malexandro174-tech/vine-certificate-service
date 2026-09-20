# Система выдачи сертификатов на именную виноградную лозу

Vine Certificate Service — n8n-мини-сервис для оформления оплаченного заказа, выдачи уникального сертификата, его активации и ведения истории лозы.

## Возможности

- Принимает тестовый webhook оплаты и валидирует входные данные.
- Не выдаёт сертификат для неоплаченного заказа.
- Защищает order_id, certificate_code и активацию от дублей.
- Формирует готовый к HTML→PDF шаблон сертификата.
- Сохраняет статусы заказа, активации и доставки в PostgreSQL.
- Активирует лозу и добавляет первое событие истории.

## Архитектура

```mermaid
flowchart LR
  P[Payment Webhook] --> W1[n8n Payment Processing]
  W1 --> DB[(PostgreSQL: vine_certificate_service)]
  W1 --> PDF[HTML / PDF certificate]
  W1 --> Mail[SMTP/Gmail delivery]
  A[Activation Webhook] --> W2[n8n Activation]
  W2 --> DB
```

## Быстрый запуск

1. Примените `database/schema.sql` к PostgreSQL Mag_OS.
2. Импортируйте `workflows/payment_processing.json` и `workflows/activation.json` в n8n.
3. Привяжите существующий PostgreSQL credential к Postgres nodes и разрешённый TEST mail credential к email node.
4. Используйте payload из `examples/`.

## Защита и ограничения demo-версии

Workflow exports не содержат credentials, токенов, паролей, реальных email или приватных URL. Реальная платёжная система заменена test webhook. PDF хранится в project output/storage, а публикация ссылки зависит от выбранного storage adapter.

## Структура

`workflows/` — n8n exports; `database/` — schema; `templates/` — сертификат; `examples/` — безопасные payload; `docs/` — архитектура, тестирование и безопасность; `submission/` — материалы для сдачи.
