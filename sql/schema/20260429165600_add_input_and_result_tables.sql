-- +goose Up
CREATE TABLE input (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending'
);

CREATE TABLE result (
    id SERIAL PRIMARY KEY,
    worker_identifier VARCHAR(50) NOT NULL,
    result TEXT NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    input_id INT,
    FOREIGN KEY (input_id) REFERENCES input(id)
    ON DELETE CASCADE
);

-- +goose Down
DROP TABLE result;
DROP TABLE input;
