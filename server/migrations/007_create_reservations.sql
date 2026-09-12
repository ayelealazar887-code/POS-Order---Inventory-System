CREATE TABLE reservations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,

    status ENUM(
        'ACTIVE',
        'CONFIRMED',
        'RELEASED',
        'EXPIRED'
    ) NOT NULL DEFAULT 'ACTIVE',

    expires_at DATETIME NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT chk_reservation_quantity CHECK (quantity > 0),

    CONSTRAINT fk_reservations_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reservations_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE RESTRICT,

    INDEX idx_reservations_order (order_id),
    INDEX idx_reservations_product (product_id),
    INDEX idx_reservations_expiry (status, expires_at)
);