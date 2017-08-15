DROP TABLE IF EXISTS bounty_available;

CREATE TABLE bounty_available (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  homeworld VARCHAR(255),
  value INT
);
