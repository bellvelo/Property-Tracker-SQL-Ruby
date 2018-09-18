DROP TABLE IF EXISTS houses;

CREATE TABLE houses (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  beds INT8,
  year INT8
);
