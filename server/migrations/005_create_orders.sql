CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,

    status ENUM(
        'PENDING',
        'RESERVED',
        'PAID',
        'FAILED',
        'EXPIRED',
        'CANCELLED',
        'REFUNDED'
    ) NOT NULL DEFAULT 'PENDING',

    total_price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    idempotency_key VARCHAR(255) NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_order_total CHECK (total_price >= 0),

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_order_idempotency UNIQUE (idempotency_key),

    INDEX idx_orders_user (user_id),
    INDEX idx_orders_status (status)
);