
-- 1.	Guideline #1: here is a list of features and specifications that Udiddit needs in order to support its website and administrative interface:
-- a.	Allow new users to register:

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(25) NOT NULL,
    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT not_empty_username CHECK (LENGTH(TRIM(username)) > 0)
);

-- b.	Allow registered users to create new topics:

CREATE TABLE topics (
    id SERIAL PRIMARY KEY,
    topic_name VARCHAR(30) NOT NULL,
    description VARCHAR(500) DEFAULT NULL,
    CONSTRAINT unique_topics UNIQUE (topic_name),
    CONSTRAINT non_empty_topic_name CHECK (LENGTH(TRIM(topic_name)) > 0)
);

-- c.	Allow registered users to create new posts on existing topics:

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    post_title VARCHAR(100) NOT NULL,
    url VARCHAR(200) DEFAULT NULL,
    text_content TEXT DEFAULT NULL,
    topic_id INTEGER REFERENCES topics ON DELETE CASCADE,
    user_id INTEGER REFERENCES users ON DELETE SET NULL,
    CONSTRAINT url_or_text CHECK ((url IS NOT NULL AND text_content IS NULL) OR
                                  (url IS NULL AND text_content IS NOT NULL))
);

-- d.	Allow registered users to comment on existing posts:

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    text_content TEXT NOT NULL,


)



