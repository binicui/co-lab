-- ================================================================================
-- H2 데이터베이스 테이블 구조 정의 스크립트
-- ================================================================================

DROP TABLE IF EXISTS USERS CASCADE;
CREATE TABLE IF NOT EXISTS USERS (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    EMAIL                   VARCHAR(45)             UNIQUE NOT NULL,
    PASSWORD                VARCHAR(255)            NOT NULL,
    NICKNAME                VARCHAR(15)             UNIQUE NOT NULL,
    NAME                    VARCHAR(15)             NOT NULL,
    PHONE                   VARCHAR(11)             NOT NULL,
    LOGIN_TYPE              CHAR(5)                 NOT NULL,
    ENABLED                 TINYINT(1)              NOT NULL,
    DELETED_YN              CHAR(1)                 NOT NULL DEFAULT 'N',
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    DELETED_AT              DATETIME                NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS USER_ROLES CASCADE;
CREATE TABLE IF NOT EXISTS USER_ROLES (
    USER_ID                 INT                     NOT NULL,
    ROLE_TYPE               VARCHAR(20)             NOT NULL,
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    PRIMARY KEY (USER_ID, ROLE_TYPE),
    CONSTRAINT FK_USER_ROLES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);

DROP TABLE IF EXISTS PROFILES CASCADE;
CREATE TABLE IF NOT EXISTS PROFILEES (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    USER_ID                 INT                     NOT NULL,
    PROFILE_IMG_URL         VARCHAR(255)            NULL,
    BIO                     VARCHAR(150)            NULL,
    UNIV                    VARCHAR(50)             NULL,
    LOCATION                VARCHAR(50)             NULL,
    URL                     VARCHAR(255)            NULL,
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_PROFILES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);

DROP TABLE IF EXISTS LOGIN_HISTORIES CASCADE;
CREATE TABLE IF NOT EXISTS LOGIN_HISTORIES (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    USER_ID                 INT                     NOT NULL,
    IP_ADDRESS              VARCHAR(15)             NOT NULL,
    DEVICE                  VARCHAR(20)             NOT NULL,
    OS                      VARCHAR(25)             NOT NULL,
    BROWSER                 VARCHAR(25)             NOT NULL,
    EVENT_TYPE              CHAR(1)                 NOT NULL,
    LOGIN_AT                DATETIME                NOT NULL,
    LOGOUT_AT               DATETIME                NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_LOGIN_HISTORIES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);



DROP TABLE IF EXISTS BOARDS CASCADE;
CREATE TABLE IF NOT EXISTS BOARDS (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    NAME                    VARCHAR(50)             NOT NULL,
    DESCRIPTION             VARCHAR(250)            NOT NULL,
    SORT                    INT                     NOT NULL,
    DELETED_YN              CHAR(1)                 NOT NULL DEFAULT 'N',
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    DELETED_AT              DATETIME                NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS POSTS CASCADE;
CREATE TABLE IF NOT EXISTS POSTS (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    BOARD_ID                INT                     NOT NULL,
    USER_ID                 INT                     NOT NULL,
    TITLE                   VARCHAR(150)            NOT NULL,
    CONTENTS                TEXT                    NOT NULL,
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_POSTS_BOARD_ID FOREIGN KEY (BOARD_ID) REFERENCES BOARDS (ID),
    CONSTRAINT FK_POSTS_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);

DROP TABLE IF EXISTS POST_ATTACHMENTS CASCADE;
CREATE TABLE IF NOT EXISTS POST_ATTACHMENTS (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    POST_ID                 INT                     NOT NULL,
    ORIGINAL_NAME           VARCHAR(255)            NOT NULL,
    SAVED_PATH              VARCHAR(255)            NOT NULL,
    SAVED_NAME              VARCHAR(255)            NOT NULL,
    EXTENSION               CHAR(8)                 NOT NULL,
    FILE_SIZE               INT                     NOT NULL,
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_POST_ATTACHMENTS_POST_ID FOREIGN KEY (POST_ID) REFERENCES POSTS (ID)
);

DROP TABLE IF EXISTS POST_LIKES CASCADE;
CREATE TABLE IF NOT EXISTS POST_LIKES (
    POST_ID                 INT                     NOT NULL,
    USER_ID                 INT                     NOT NULL,
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    PRIMARY KEY (POST_ID, USER_ID),
    CONSTRAINT FK_POST_LIKES_POST_ID FOREIGN KEY (POST_ID) REFERENCES POSTS (ID),
    CONSTRAINT FK_POST_LIKES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);

DROP TABLE IF EXISTS COMMENTS CASCADE;
CREATE TABLE IF NOT EXISTS COMMENTS (
    ID                      INT                     NOT NULL AUTO_INCREMENT,
    POST_ID                 INT                     NOT NULL,
    PARENT_COMMENT_ID       INT                     NULL,
    USER_ID                 INT                     NOT NULL,
    CONTENTS                VARCHAR(300)            NOT NULL,
    DEPTH                   INT                     NOT NULL,
    SORT                    INT                     NOT NULL,
    DELETED_YN              CHAR(1)                 NOT NULL DEFAULT 'N',
    CREATED_AT              DATETIME                NOT NULL DEFAULT NOW(),
    UPDATED_AT              DATETIME                NOT NULL,
    DELETED_AT              DATETIME                NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_COMMENTS_POST_ID FOREIGN KEY (POST_ID) REFERENCES POSTS (ID),
    CONSTRAINT FK_COMMENTS_PARENT_COMMENT_ID FOREIGN KEY (PARENT_COMMENT_ID) REFERENCES COMMENTS (ID),
    CONSTRAINT FK_COMMENTS_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);
