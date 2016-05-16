CREATE TABLE items (
  id INT AUTO_INCREMENT NOT NULL,
  item_code INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  img_src VARCHAR(255),
  specs VARCHAR(255),
  display_type VARCHAR(255),
  metric VARCHAR(255),
  description TEXT,
  main_category_id INT NOT NULL,
  category_id INT NOT NULL,
  create_time DATETIME NOT NULL,
  update_time DATETIME NOT NULL,
  delete_flag TINYINT(2) DEFAULT 0,
  PRIMARY KEY (id)
);
