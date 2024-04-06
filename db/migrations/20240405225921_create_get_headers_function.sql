-- migrate:up

CREATE OR REPLACE FUNCTION get_headers() RETURNS jsonb
    LANGUAGE sql STABLE
AS $$
SELECT current_setting('request.headers', true)::json
$$;

-- migrate:down

DROP FUNCTION get_headers();