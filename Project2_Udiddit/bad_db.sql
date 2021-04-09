CREATE TABLE bad_posts (
    id SERIAL PRIMARY KEY,
    topic VARCHAR(50),
    username VARCHAR(50),
    title VARCHAR(150),
    url VARCHAR(4000) DEFAULT NULL,
    text_content TEXT DEFAULT NULL,
    upvotes TEXT,
    downvotes TEXT
);
CREATE TABLE bad_comments (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    post_id BIGINT,
    text_content TEXT
);
INSERT INTO "bad_posts" VALUES
    (1,'Synergized','Gus32','numquam quia laudantium non sed libero optio sit aliquid aut voluptatem',NULL,'Voluptate ut similique libero architecto accusantium inventore fuga. Maxime est consequatur repellendus commodi. Consequatur veniam debitis consequatur. Et eaque a. Magnam ea rerum eos modi. Accusamus aut impedit perferendis. Quasi est ipsum.','Judah.Okuneva94,Dasia98,Maurice_Dooley14,Dangelo_Lynch59,Brandi.Schaefer,Jayde.Kulas74,Katarina_Hudson,Ken.Murphy42','Lambert.Buckridge0,Joseph_Pouros82,Jesse_Yost'),
    (2,'Applications','Keagan_Howell','officia temporibus molestias sequi ea qui','http://lesley.com',NULL,'Marcellus31,Amina_Larson,Vicky_Hilll,Angelo_Aufderhar64,Javier25,Wilhelmine99,Danika_Renner88','Aniyah_Balistreri68,Demarcus.Berge,Melody.Ondricka,Ruben_Kuvalis,Marlin_Klocko7,Dangelo_Lynch59,Alana_Mayer17,Caleigh.McKenzie'),
    (3,'Buckinghamshire','Gertrude.Nicolas48','officiis accusamus qui at blanditiis dolor sit','http://aurelie.name',NULL,'Evangeline.Koss65,Adolfo_Ward,Ariel.Armstrong,Domingo_Ratke,Noble41','Reinhold.Little,Rosalyn44,Ezequiel_Lindgren,Adriel50,Keith.Schroeder,Opal.Schulist22,Carissa54,Lora7,Eudora_Dickinson68,Morgan.Aufderhar89');

INSERT INTO "bad_comments" VALUES
    (501,'Makenzie_Hessel10',156,'Quam officiis qui rem animi. Laudantium amet veniam et ratione. Id reprehenderit non ut eaque qui distinctio. Et dolores omnis. Ipsum deserunt molestiae eum fugiat.'),
    (502,'Brionna_Lubowitz79',8757,'Itaque cum porro exercitationem molestiae autem facilis enim dolore id.'),
    (503,'Cecelia.Satterfield',7261,'Accusamus aperiam quasi. Error dolores vel qui eaque eum corporis. At officiis labore veniam consequatur.'),
    (504,'Dell.Okuneva',9499,'Ipsam excepturi earum quos expedita error nulla. Fugit officiis enim odio consequatur tempora consequatur adipisci occaecati explicabo. Molestiae veritatis placeat atque dolor a. Corrupti consectetur modi nihil fuga facilis. Necessitatibus omnis minima. Reiciendis vel ea qui eum aut ad minus aut quo. Aut reprehenderit fuga laborum eveniet illo consequatur est facilis sit. Ut dolorum vero officiis et iste accusantium est.'),
    (505,'Antonetta_Buckridge47',1101,'Tenetur illo aliquid in. Inventore aut dolores itaque dolores corporis fuga consequuntur vero minus. Omnis ullam ut voluptas eius non excepturi vel. Pariatur ut quas rerum assumenda non. Aut et explicabo dolores laboriosam ut recusandae et aut. In quia et cum quia suscipit esse.'),
    (506,'Robert_Zieme58',8163,'Maiores qui eligendi aut blanditiis. Omnis deserunt placeat. Occaecati est accusamus sed impedit enim. Omnis dolorem deleniti est pariatur repudiandae quod nobis atque. Est magni dignissimos voluptatem suscipit aut aut et autem.');

