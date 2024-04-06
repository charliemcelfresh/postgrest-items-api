-- migrate:up

GRANT USAGE ON SCHEMA public TO web_anon;
GRANT SELECT ON public.get_user_items TO web_anon;

-- migrate:down

REVOKE USAGE ON SCHEMA public FROM web_anon;
REVOKE SELECT ON public.get_users_items FROM web_anon;