-- migrate:up

COPY users (email) FROM '/Users/charlie/go/src/github.com/charliemcelfresh/postgrest-items-api/db/users.txt';
COPY items (name) FROM '/Users/charlie/go/src/github.com/charliemcelfresh/postgrest-items-api/db/items.txt';
insert into user_items (user_id, item_id) select u.id as user_id, i.id as item_id from users u cross join items i;

-- migrate:down

DELETE FROM user_items;
DELETE FROM users;
DELETE FROM items;