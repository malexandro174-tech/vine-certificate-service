CREATE SCHEMA IF NOT EXISTS vine_certificate_service;

CREATE TABLE vine_certificate_service.orders (
  order_id text PRIMARY KEY,
  client_name text NOT NULL,
  email text NOT NULL CHECK (position('@' in email) > 1),
  certificate_name text NOT NULL,
  amount numeric(12,2) NOT NULL CHECK (amount > 0),
  payment_status text NOT NULL CHECK (payment_status IN ('paid','unpaid','rejected')),
  certificate_code text UNIQUE,
  certificate_link text,
  activation_status text NOT NULL DEFAULT 'inactive' CHECK (activation_status IN ('inactive','active')),
  activated_at timestamptz,
  email_status text NOT NULL DEFAULT 'pending',
  pdf_status text NOT NULL DEFAULT 'pending',
  processing_status text NOT NULL DEFAULT 'received',
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE vine_certificate_service.vines (
  certificate_code text PRIMARY KEY REFERENCES vine_certificate_service.orders(certificate_code),
  owner_name text NOT NULL,
  vine_name text NOT NULL,
  photo_link text,
  status text NOT NULL CHECK (status IN ('active','inactive')),
  last_update timestamptz NOT NULL DEFAULT now(),
  activated_at timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE vine_certificate_service.vine_updates (
  id bigserial PRIMARY KEY,
  certificate_code text NOT NULL REFERENCES vine_certificate_service.vines(certificate_code) ON DELETE CASCADE,
  update_text text NOT NULL,
  photo_link text,
  date date NOT NULL DEFAULT current_date,
  created_at timestamptz NOT NULL DEFAULT now()
);
