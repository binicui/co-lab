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
    LOGOUT_AT               DATETIME                NULL
    PRIMARY KEY (ID),
    CONSTRAINT FK_LOGIN_HISTORIES_USER_ID FOREIGN KEY (USER_ID) REFERENCES USERS (ID)
);
