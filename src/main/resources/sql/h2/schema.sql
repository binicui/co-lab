--
-- # H2 In-Memory DB 테이블 설계
--



-- #####################################################################################################################
--  # 회원 관련 테이블 설계
-- #####################################################################################################################

-- # 회원 테이블
DROP TABLE IF EXISTS USERS CASCADE;
CREATE TABLE IF NOT EXISTS USERS COMMENT '회원' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    email                   VARCHAR(45)                 UNIQUE NOT NULL,
    password                VARCHAR(255)                NOT NULL,
    nickname                VARCHAR(15)                 UNIQUE NOT NULL,
    name                    VARCHAR(15)                 NOT NULL,
    phone                   VARCHAR(11)                 NOT NULL,
    login_type              VARCHAR(5)                  NOT NULL,
    enabled                 TINYINT(1)                  NOT NULL,
    deleted_yn              CHAR(1)                     NOT NULL DEFAULT 'N',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    deleted_at              DATETIME                    NULL,
    PRIMARY KEY (id)
);


-- # 회원별 보유 권한 테이블
DROP TABLE IF EXISTS USER_ROLES CASCADE;
CREATE TABLE IF NOT EXISTS USER_ROLES COMMENT '회원별 보유 권한' (
    user_id                 INT                         NOT NULL,
    role_type               VARCHAR(15)                 NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (user_id, role_type),
    CONSTRAINT FK_USER_ROLES_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 회원 프로필 테이블
DROP TABLE IF EXISTS PROFILES CASCADE;
CREATE TABLE IF NOT EXISTS PROFILES COMMENT '회원 프로필 정보' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    user_id                 INT                         NOT NULL,
    profile_img_url         VARCHAR(255)                NULL,
    bio                     VARCHAR(150)                NULL,
    univ                    VARCHAR(50)                 NULL,
    location                VARCHAR(50)                 NULL,
    url                     VARCHAR(255)                NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_PROFILES_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 로그인 이력 테이블
DROP TABLE IF EXISTS LOGIN_HISTORY CASCADE;
CREATE TABLE IF NOT EXISTS LOGIN_HISTORY COMMENT '로그인 및 로그아웃 이력' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    user_id                 INT                         NOT NULL,
    ip_address              VARCHAR(15)                 NOT NULL,
    device                  VARCHAR(15)                 NOT NULL,
    os                      VARCHAR(20)                 NOT NULL,
    browser                 VARCHAR(20)                 NOT NULL,
    event_type              CHAR(1)                     NOT NULL,
    login_at                DATETIME                    NOT NULL,
    logout_at               DATETIME                    NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_LOGIN_HISTORY_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);



-- #####################################################################################################################
--  # 팀 관련 테이블 설계
-- #####################################################################################################################

-- # 팀 정보 테이블
DROP TABLE IF EXISTS TEAMS CASCADE;
CREATE TABLE IF NOT EXISTS TEAMS COMMENT '팀 정보' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    name                    VARCHAR(100)                NOT NULL,
    summary                 VARCHAR(150)                NOT NULL,
    created_by              INT                         NOT NULL,
    deleted_yn              CHAR(1)                     NOT NULL DEFAULT 'N',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    deleted_at              DATETIME                    NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_TEAMS_CREATED_BY FOREIGN KEY (created_by) REFERENCES USERS (user_id)
);


-- # 팀원 테이블
DROP TABLE IF EXISTS TEAM_USERS CASCADE;
CREATE TABLE IF NOT EXISTS TEAM_USERS COMMENT '팀원' (
    team_id                 INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    is_captain              CHAR(1)                     NOT NULL,
    PRIMARY KEY (team_id, user_id),
    CONSTRAINT FK_TEAM_USERS_TEAM_ID FOREIGN KEY (team_id) REFERENCES TEAMS (id),
    CONSTRAINT FK_TEAM_USERS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);




-- #####################################################################################################################
--  # 프로젝트 및 업무 관련 테이블 설계
-- #####################################################################################################################

-- # 업무 그룹 테이블
DROP TABLE IF EXISTS TASK_GROUPS CASCADE;
CREATE TABLE IF NOT EXISTS TASK_GROUPS COMMENT '업무 그룹' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    name                    VARCHAR(50)                 NOT NULL,
    sort                    INT                         NOT NULL,
    used_yn                 CHAR(1)                     NOT NULL DEFAULT 'Y',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id)
);


-- # 프로젝트 정보 테이블
DROP TABLE IF EXISTS PROJECTS CASCADE;
CREATE TABLE IF NOT EXISTS PROJECTS COMMENT '프로젝트 정보' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    team_id                 INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    summary                 VARCHAR(200)                NOT NULL,
    start_date              DATE                        NOT NULL,
    end_date                DATE                        NOT NULL,
    status                  CHAR(1)                     NOT NULL,
    deleted_yn              CHAR(1)                     NOT NULL DEFAULT 'N',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    deleted_at              DATETIME                    NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_PROJECTS_TEAM_ID FOREIGN KEY (team_id) REFERENCES TEAMS (id),
    CONSTRAINT FK_PROJECTS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 프로젝트 업무 테이블
DROP TABLE IF EXISTS PROJECT_TASKS CASCADE;
CREATE TABLE IF NOT EXISTS PROJECT_TASKS COMMENT '프로젝트 업무' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    project_id              INT                         NOT NULL,
    name                    VARCHAR(150)                NOT NULL,
    task_group_id           INT                         NOT NULL,
    start_date              DATE                        NOT NULL,
    end_date                DATE                        NOT NULL,
    actual_end_date         DATE                        NULL,
    rate                    INT                         NOT NULL DEFAULT 0,
    sort                    INT                         NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_PROJECT_TASKS_PROJECT_ID FOREIGN KEY (project_id) REFERENCES PROJECTS (id),
    CONSTRAINT FK_PROJECT_TASKS_TASK_GROUP_ID FOREIGN KEY (task_group_id) REFERENCES TASK_GROUPS (id)
);


-- # 프로젝트 업무 할당 테이블
DROP TABLE IF EXISTS TASK_ALLOCATIONS CASCADE;
CREATE TABLE IF NOT EXISTS TASK_ALLOCATIONS COMMENT '프로젝트 업무 할당' (
    project_task_id         INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    PRIMARY KEY (project_task_id, user_id),
    CONSTRAINT FK_TASK_ALLOCATIONS_PROJECT_TASKS_ID FOREIGN KEY (project_task_id) REFERENCES PROJECT_TASKS (id),
    CONSTRAINT FK_TASK_ALLOCATIONS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 프로젝트 업무 산출물 테이블
DROP TABLE IF EXISTS TASK_ATTACHMENTS CASCADE;
CREATE TABLE IF NOT EXISTS TASK_ATTACHMENTS COMMENT '프로젝트 업무 산출물' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    project_task_id         INT                         NOT NULL,
    original_name           VARCHAR(255)                NOT NULL,
    saved_path              VARCHAR(255)                NOT NULL,
    saved_name              VARCHAR(255)                NOT NULL,
    extension               VARCHAR(8)                  NOT NULL,
    file_size               INT                         NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_TASK_ATTACHMENTS_PROJECT_TASK_ID FOREIGN KEY (project_task_id) REFERENCES PROJECT_TASKS (id)
);


-- # 프로젝트 회의록 테이블
DROP TABLE IF EXISTS MEETING_MINUTES CASCADE;
CREATE TABLE IF NOT EXISTS MEETING_MINUTES COMMENT '프로젝트 회의록' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    project_id              INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    title                   VARCHAR(150)                NOT NULL,
    contents                TEXT                        NOT NULL,
    meeting_date            DATE                        NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_MEETING_MINUTES_PROJECT_ID FOREIGN KEY (project_id) REFERENCES PROJECTS (id),
    CONSTRAINT FK_MEETING_MINUTES_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 프로젝트 회의 참여자 테이블
DROP TABLE IF EXISTS MEETING_PARTICIPANTS CASCADE;
CREATE TABLE IF NOT EXISTS MEETING_PARTICIPANTS COMMENT '프로젝트 회의 참여자' (
    meeting_id              INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    PRIMARY KEY (meeting_id, user_id),
    CONSTRAINT FK_MEETING_PARTICIPANTS_MEETING_ID FOREIGN KEY (meeting_id) REFERENCES MEETING_MINUTES (id),
    CONSTRAINT FK_MEETING_PARTICIPANTS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);




-- #####################################################################################################################
--  # 게시판 관련 테이블 설계
-- #####################################################################################################################

-- # 게시판 테이블
DROP TABLE IF EXISTS BOARDS CASCADE;
CREATE TABLE IF NOT EXISTS BOARDS COMMENT '게시판' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    name                    VARCHAR(55)                 NOT NULL,
    description             VARCHAR(150)                NOT NULL,
    deleted_yn              CHAR(1)                     NOT NULL DEFAULT 'N',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    deleted_at              DATETIME                    NULL,
    PRIMARY KEY (id)
);


-- # 게시글 테이블
DROP TABLE IF EXISTS POSTS CASCADE;
CREATE TABLE IF NOT EXISTS POSTS COMMENT '게시글' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    board_id                INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    title                   VARCHAR(150)                NOT NULL,
    contents                TEXT                        NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_POSTS_BOARD_ID FOREIGN KEY (board_id) REFERENCES BOARDS (id),
    CONSTRAINT FK_POSTS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 게시글 좋아요 테이블
DROP TABLE IF EXISTS POST_LIKES CASCADE;
CREATE TABLE IF NOT EXISTS POST_LIKES COMMENT '게시글 좋아요' (
    post_id                 INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    PRIMARY KEY (post_id, user_id),
    CONSTRAINT FK_POST_LIKES_POST_ID FOREIGN KEY (post_id) REFERENCES POSTS (id),
    CONSTRAINT FK_POST_LIKES_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id)
);


-- # 게시글 첨부파일 테이블
DROP TABLE IF EXISTS POST_ATTACHMENTS CASCADE;
CREATE TABLE IF NOT EXISTS POST_ATTACHMENTS COMMENT '게시글 첨부파일' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    post_id                 INT                         NOT NULL,
    original_name           VARCHAR(255)                NOT NULL,
    saved_path              VARCHAR(255)                NOT NULL,
    saved_name              VARCHAR(255)                NOT NULL,
    extension               VARCHAR(8)                  NOT NULL,
    file_size               INT                         NOT NULL,
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_POST_ATTACHMENTS_POST_ID FOREIGN KEY (post_id) REFERENCES POSTS (id)
);


-- # 댓글 테이블
DROP TABLE IF EXISTS COMMENTS CASCADE;
CREATE TABLE IF NOT EXISTS COMMENTS COMMENT '댓글' (
    id                      INT                         NOT NULL AUTO_INCREMENT,
    post_id                 INT                         NOT NULL,
    user_id                 INT                         NOT NULL,
    parent_comment_id       INT                         NULL,
    contents                VARCHAR(300)                NOT NULL,
    depth                   INT                         NOT NULL,
    sort                    INT                         NOT NULL,
    deleted_yn              CHAR(1)                     NOT NULL DEFAULT 'N',
    created_at              DATETIME                    NOT NULL DEFAULT NOW(),
    updated_at              DATETIME                    NOT NULL,
    deleted_at              DATETIME                    NULL,
    PRIMARY KEY (id),
    CONSTRAINT FK_COMMENTS_POST_ID FOREIGN KEY (post_id) REFERENCES POSTS (id),
    CONSTRAINT FK_COMMENTS_USER_ID FOREIGN KEY (user_id) REFERENCES USERS (id),
    CONSTRAINT FK_COMMENTS_PARENT_COMMENT_ID FOREIGN KEY (parent_comment_id) REFERENCES COMMENTS (id)
);