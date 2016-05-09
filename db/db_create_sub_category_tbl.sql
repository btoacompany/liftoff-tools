CREATE TABLE sub_category (
  id INT AUTO_INCREMENT NOT NULL,
  category_id INT NOT NULL,
  main_category_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  create_time DATETIME NOT NULL,
  update_time DATETIME NOT NULL,
  delete_flag TINYINT(2) DEFAULT 0,
  PRIMARY KEY (id)
);
