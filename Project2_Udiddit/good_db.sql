----------------- Part II: Create the DDL for your new schema -----------------
-- 1.	Guideline #1: here is a list of features and specifications that Udiddit needs
-- in order to support its website and administrative interface

-- 2.	Guideline #2: here is a list of queries that Udiddit needs in order to support
-- its website and administrative interface. Note that you don’t need to produce the DQL
-- for those queries: they are only provided to guide the design of your new database schema.

-- 3.	Guideline #3: you’ll need to use normalization, various constraints, as well as indexes
-- in your new database schema. You should use named constraints and indexes to make your
-- schema cleaner.

-- 4.	Guideline #4: your new database schema will be composed of five (5) tables that
-- should have an auto-incrementing id as their primary key.


-- a.	Allow new users to register:

CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(25) NOT NULL,
    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT not_empty_username CHECK (LENGTH(TRIM(username)) > 0)
);

-- b.	Allow registered users to create new topics:

CREATE TABLE topics
(
    id          SERIAL PRIMARY KEY,
    topic_name  VARCHAR(30) NOT NULL,
    description VARCHAR(500) DEFAULT NULL,
    CONSTRAINT unique_topics UNIQUE (topic_name),
    CONSTRAINT non_empty_topic_name CHECK (LENGTH(TRIM(topic_name)) > 0)
);

-- c.	Allow registered users to create new posts on existing topics:

CREATE TABLE posts
(
    id           SERIAL PRIMARY KEY,
    post_title   VARCHAR(100) NOT NULL,
    url          VARCHAR(200) DEFAULT NULL,
    text_content TEXT         DEFAULT NULL,
    topic_id     INTEGER REFERENCES topics ON DELETE CASCADE,
    user_id      INTEGER      REFERENCES users ON DELETE SET NULL,
    CONSTRAINT url_or_text CHECK (
            (LENGTH(TRIM(url)) > 0 AND LENGTH(TRIM(text_content)) = 0) OR
            (LENGTH(TRIM(url)) = 0 AND LENGTH(TRIM(text_content)) > 0)
        )
);

-- d.	Allow registered users to comment on existing posts:

CREATE TABLE comments
(
    id                SERIAL PRIMARY KEY,
    text_content      TEXT    NOT NULL,
    post_id           INTEGER REFERENCES posts ON DELETE CASCADE,
    user_id           INTEGER REFERENCES users ON DELETE SET NULL,
    parent_comment_id INTEGER REFERENCES comments ON DELETE CASCADE,
    CONSTRAINT non_empty_text_content CHECK (LENGTH(TRIM(text_content)) > 0)
);

-- e.	Make sure that a given user can only vote once on a given post:

CREATE TABLE votes
(
    id      SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users ON DELETE SET NULL,
    post_id INTEGER REFERENCES posts ON DELETE CASCADE,
    vote    SMALLINT CHECK (vote = 1 OR vote = -1),
    CONSTRAINT unique_vote UNIQUE (user_id, post_id)
);

----------------- Part III: Migrate the provided data -----------------
----------------TOPICS------------------

INSERT INTO topics(topic_name)
SELECT DISTINCT topic
FROM bad_posts;

---------------USERS-------------------

INSERT INTO users(username)
SELECT DISTINCT username
FROM bad_posts
UNION
SELECT DISTINCT username
FROM bad_comments
UNION
SELECT DISTINCT REGEXP_SPLIT_TO_TABLE(upvotes, ',')
FROM bad_posts
UNION
SELECT DISTINCT REGEXP_SPLIT_TO_TABLE(downvotes, ',')
FROM bad_posts;

----------------POSTS------------------

INSERT INTO posts (post_title, url, text_content, topic_id, user_id)
SELECT LEFT(bp.title, 100),
       LEFT(bp.url, 200),
       bp.text_content,
       t.id,
       u.id
FROM users u
         JOIN bad_posts bp
              ON bp.username = u.username
         JOIN topics t
              ON bp.topic = t.topic_name;

---------------COMMENTS-------------------

INSERT INTO comments (text_content, post_id, user_id)
SELECT bc.text_content, p.id, u.id
FROM users u
         JOIN bad_comments bc ON bc.username = u.username
         JOIN posts p ON bc.post_id = p.id;

---------------VOTES----------------------

INSERT INTO votes (post_id, user_id, vote)
SELECT bp_up.id,
       u.id,
       1 AS vote_up
FROM (SELECT id, REGEXP_SPLIT_TO_TABLE(upvotes, ',') AS upvote_users
      FROM bad_posts) bp_up
         JOIN users u
              ON u.username = bp_up.upvote_users
UNION
SELECT bp_down.id,
       u.id,
       -1 AS vote_down
FROM (SELECT id, REGEXP_SPLIT_TO_TABLE(downvotes, ',') AS downvote_users
      FROM bad_posts) bp_down
         JOIN users u
              ON u.username = bp_down.downvote_users;