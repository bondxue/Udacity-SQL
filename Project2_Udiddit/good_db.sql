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

INSERT INTO topics(topic_name)
SELECT DISTINCT topic
FROM bad_posts;


