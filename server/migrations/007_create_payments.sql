CREATE TABLE payments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    order_id BIGINT UNSIGNED NOT NULL,

    amount DECIMAL(10, 2) NOT NULL,

    status ENUM(
        'PENDING',
        'SUCCESS',
        'FAILED',
        'TIMEOUT'
    ) NOT NULL DEFAULT 'PENDING',

    transaction_id VARCHAR(255) NULL,

    idempotency_key VARCHAR(255) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0),

    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_payment_idempotency
        UNIQUE (idempotency_key),

    CONSTRAINT uq_payment_transaction
        UNIQUE (transaction_id),

    INDEX idx_payments_order (order_id)
);