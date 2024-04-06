-- migrate:up

CREATE TABLE user_items (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT references users(id),
    item_id BIGINT references items(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );

CREATE INDEX idx_user_items_user_id ON user_items (user_id);
CREATE INDEX idx_user_items_item_id ON user_items (item_id);

-- migrate:down

DROP TABLE user_items;
