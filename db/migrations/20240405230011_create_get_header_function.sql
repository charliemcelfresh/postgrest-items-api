-- migrate:up

CREATE OR REPLACE FUNCTION get_header(item text) RETURNS text
    LANGUAGE sql STABLE
AS $$
SELECT (current_setting('request.headers', true)::json)->>item
$$;

-- migrate:down

DROP FUNCTION get_header(item text);