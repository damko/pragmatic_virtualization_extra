CREATE TABLE topics (
    id INT unsigned NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    PRIMARY KEY(id)
);

INSERT INTO topics (
    title,
    description
) VALUES (
    'Make Rainbow ElePHPants',
    'Create an elePHPant with rainbow fur'
);

INSERT INTO topics (
    title,
    description
) VALUES (
    'Make Giant Kittens',
    'Like kittens, but larger'
);

INSERT INTO topics (
    title,
    description
) VALUES (
    'Complete PHPBridge',
    'Because I am awesome'
);
