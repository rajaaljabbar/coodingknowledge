CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(300),
    last_name VARCHAR(300),
    phone VARCHAR(300),
    email VARCHAR(300),
    join_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(255) NOT NULL DEFAULT 'SYSTEM',
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(255) NOT NULL DEFAULT 'SYSTEM'
);

INSERT INTO customers (id, first_name, last_name, phone, email, join_date, created_by, updated_by) VALUES 
    (61867, 'sample_first_name', 'sample_last_name', 'sample_phone', 'sample_email', '2024-01-01', 'admin', 'admin'),
    (50546, 'sample_first_name', 'sample_last_name', 'sample_phone', 'sample_email', '2024-01-02', 'admin', 'admin'),
    (38428, 'sample_first_name', 'sample_last_name', 'sample_phone', 'sample_email', '2024-01-03', 'admin', 'admin');

	select * from customers;

	
	/* create table product , it must contains stock and expired date */
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,          -- Unique product ID
    product_name VARCHAR(100) NOT NULL,    -- Product name
    stock INT NOT NULL CHECK (stock >= 0), -- Stock quantity
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0), -- Price of the product
    expired_date DATE NOT NULL,            -- Expiration date of the product
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Record creation time
);

	/*insert table product */	
INSERT INTO product (product_name, stock, price, expired_date) VALUES
    ('Milk', 100, 2.50, '2025-12-31'),
    ('Bread', 50, 1.20, '2025-01-20'),
    ('Eggs', 200, 3.00, '2025-02-15');

	select * from product;
	
	/*create table account, it must contains username password and balance */
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
	customer_id integer NOT NULL,
    password VARCHAR(255) NOT NULL,
    balance DECIMAL(15, 2) NOT NULL CHECK (balance >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	foreign key (customer_id) references customers(id) on delete cascade
);
	/*insert table account */	
INSERT INTO account (username, password, balance) VALUES
    ('user1', 'password1', 500.00),
    ('user2', 'password2', 1000.00);

	select * from account;
	
	
	/*create table cart, it must contain account info and product info */
CREATE TABLE cart (
    cart_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_account FOREIGN KEY (account_id) REFERENCES account(account_id),
    CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES product(product_id)
);
	/*insert table cart */
INSERT INTO cart (account_id, product_id, quantity) VALUES
    (1, 1, 2),
    (2, 3, 5);

	select * from cart;

		/*create table transaction, it must contains acccount info, product info, and cart */
CREATE TABLE transaction (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT NOT NULL,
    product_id INT NOT NULL,
    cart_id INT NOT NULL,
    total_amount DECIMAL(15, 2) NOT NULL CHECK (total_amount >= 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaction_account FOREIGN KEY (account_id) REFERENCES account(account_id),
    CONSTRAINT fk_transaction_product FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT fk_transaction_cart FOREIGN KEY (cart_id) REFERENCES cart(cart_id)
);
	/*insert table transaction */
INSERT INTO transaction (account_id, product_id, cart_id, total_amount) VALUES
    (1, 1, 1, 5.00),
    (2, 3, 2, 15.00);

	select * from transaction;