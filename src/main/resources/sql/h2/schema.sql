--
-- # H2 In-Memory DB 테이블 설계
--

-- # 테이블 설명
--DROP TABLE IF EXISTS 테이블명 CASCADE;
--CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
--    PRIMARY KEY ()
--);

-- # 테이블 설명
--DROP TABLE IF EXISTS 테이블명 CASCADE;
--CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
--    PRIMARY KEY (),
--    CONSTRAINT 제약조건명 FOREIGN KEY (외래키명) REFERENCES 참조테이블명 (참조테이블의PK)
--);

-- # 테이블 설명
--DROP TABLE IF EXISTS 테이블명 CASCADE;
--CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
--    PRIMARY KEY (),
--    CONSTRAINT 제약조건명 FOREIGN KEY (외래키명) REFERENCES 참조테이블명 (참조테이블의PK),
--    CONSTRAINT 제약조건명 FOREIGN KEY (외래키명) REFERENCES 참조테이블명 (참조테이블의PK)
--);


-- #####################################################################################################################
--  # 테이블 정의
-- #####################################################################################################################

-- # 회원 테이블
DROP TABLE IF EXISTS 테이블명 CASCADE;
CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
    PRIMARY KEY ()
);


-- # 회원별 보유 권한 테이블
DROP TABLE IF EXISTS 테이블명 CASCADE;
CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
    PRIMARY KEY (),
    CONSTRAINT 제약조건명 FOREIGN KEY (외래키명) REFERENCES 참조테이블명 (참조테이블의PK)
);


-- # 회원 프로필 테이블
DROP TABLE IF EXISTS 테이블명 CASCADE;
CREATE TABLE IF NOT EXISTS 테이블명 COMMENT '' (
    PRIMARY KEY (),
    CONSTRAINT 제약조건명 FOREIGN KEY (외래키명) REFERENCES 참조테이블명 (참조테이블의PK)
);