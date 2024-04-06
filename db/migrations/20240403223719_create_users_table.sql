-- migrate:up

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email TEXT NOT NULL,
    created_at timestamptz DEFAULT NOW(),
    updated_at timestamptz DEFAULT NOW()
);

CREATE UNIQUE INDEX idx_user__email ON users (email);

-- migrate:down

DROP TABLE users;
