-- migrate:up

CREATE VIEW get_user_items AS
    SELECT
        i.id, i.name, i.created_at, i.updated_at
    FROM
        items i
    JOIN
        user_items ui ON ui.item_id = i.id
    WHERE
        ui.user_id = get_header('x-user-id')::BIGINT
    LIMIT
        current_setting('postgrest.limit', TRUE)::BIGINT
    OFFSET
        current_setting('postgrest.offset', TRUE)::BIGINT;

-- migrate:down

DROP VIEW get_user_items;
