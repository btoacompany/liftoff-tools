CREATE TABLE product_shops (
  id int AUTO_INCREMENT NOT NULL,
  product_id INT NOT NULL,
  shop_id INT NOT NULL,
  shop_name VARCHAR(255) NOT NULL,
  product_url VARCHAR(255),
  img_src VARCHAR(255),
  price	INT NOT NULL,
  price_sale INT DEFAULT 0,
  price_before_sale INT DEFAULT 0,
  min_purchase INT DEFAULT 1,
  stock_status TINYINT(2) NOT NULL DEFAULT 0,
  create_time DATETIME NOT NULL,
  update_time DATETIME NOT NULL,
  delete_flag TINYINT(2) DEFAULT 0,
  PRIMARY KEY (id)
);
