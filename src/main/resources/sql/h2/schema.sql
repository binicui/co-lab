-- H2 In-Memory DB



-- ## 사용자 계정
DROP TABLE IF EXISTS users CASCADE ;
CREATE TABLE IF NOT EXISTS users COMMENT '사용자 계정 테이블' (
	id						INT						NOT NULL AUTO_INCREMENT COMMENT '사용자계정번호',
	email					VARCHAR(40)				UNIQUE NOT NULL COMMENT '이메일',
	password				VARCHAR(255)			NOT NULL COMMENT '비밀번호',
	nickname				VARCHAR(15)				UNIQUE NOT NULL COMMENT '닉네임',
	name					VARCHAR(15)				NOT NULL COMMENT '이름',
	phone					VARCHAR(11)				NOT NULL COMMENT '휴대폰 번호',
	login_type				VARCHAR(5)				NOT NULL COMMENT '로그인 유형 (LOCAL : 일반 / OAUTH : 소셜)',
	enabled					TINYINT(1)				NOT NULL COMMENT '계정 활성화',
	deleted_yn				CHAR(1)					NOT NULL COMMENT '삭제 여부 (논리적 삭제)',
	created_at				DATETIME				NOT NULL DEFAULT NOW() COMMENT '가입 일자',
	updated_at				DATETIME				NOT NULL COMMENT '변경 일자',
	deleted_at				DATETIME				NULL COMMENT '삭제 일자 (논리적 삭제)',
	PRIMARY KEY (id)
);


-- ## 사용자 권한
DROP TABLE IF EXISTS user_roles CASCADE ;
CREATE TABLE IF NOT EXISTS user_roles COMMENT '사용자 계정별 권한 테이블' (
	user_id					INT						NOT NULL COMMENT '사용자계정번호',
	role_type				VARCHAR(15)				NOT NULL COMMENT '권한 유형 (ROLE_USER : 일반 회원 / ROLE_ADMIN : 관리자)',
	created_at				DATETIME				NOT NULL DEFAULT NOW() COMMENT '권한 등록 일자',
	updated_at				DATETIME				NOT NULL DEFAULT COMMENT '권한 변경 일자',
	PRIMARY KEY (user_id, role_type)
);
ALTER TABLE user_roles ADD CONSTRAINT user_roles_user_id_FK FOREIGN KEY (user_id) REFERENCES users (id);


-- ## 사용자 프로필
DROP TABLE IF EXISTS profiles CASCADE ;
CREATE TABLE IF NOT EXISTS profiles COMMENT '사용자 프로필 테이블' (
	id						INT						NOT NULL AUTO_INCREMENT COMMENT '프로필번호',
	user_id					INT						NOT NULL COMMENT '사용자계정번호',
	profile_img_url			VARCHAR(255)			NOT NULL COMMENT '프로필 이미지 경로',
	bio						VARCHAR(150)			NOT NULL COMMENT '한 줄 소개',
	url						VARCHAR(255)			NOT NULL COMMENT '개인 블로그 및 깃허브 주소',
	univ					VARCHAR(45)				NOT NULL COMMENT '출신 대학교',
	location				VARCHAR(45)				NOT NULL COMMENT '활동 및 거주 도시명',
	created_at				DATETIME				NOT NULL DEFAULT NOW() COMMENT '프로필 등록 일자',
	updated_at				DATETIME				NOT NULL DEFAULT COMMENT '프로필 변경 일자',
	PRIMARY KEY (id)
);
ALTER TABLE profiles ADD CONSTRAINT profiles_user_id_FK FOREIGN KEY (user_id) REFERENCES users (id);


-- ## 로그인 및 로그아웃 이력 관리
DROP TABLE IF EXISTS login_history CASCADE ;
CREATE TABLE IF NOT EXISTS login_history COMMENT '로그인 이력 테이블' (
	id						INT						NOT NULL AUTO_INCREMENT COMMENT '이력번호',
	user_id					INT						NOT NULL COMMENT '사용자계정번호',
	ip_address				VARCHAR(15)				NOT NULL COMMENT '접속 IP',
	device					VARCHAR(6)				NOT NULL COMMENT '접속 장비 (PC / MOBILE)',
	os						VARCHAR(20)				NOT NULL COMMENT '운영체제',
	browser					VARCHAR(20)				NOT NULL COMMENT '웹브라우저',
	event_type				CHAR(1)					NOT NULL COMMENT '로그인/로그아웃 구분 코드',
	login_at				DATETIME				NOT NULL COMMENT '로그인 일자',
	logout_at				DATETIME				NULL COMMENT '로그아웃 일자',
	PRIMARY KEY (id)
);
ALTER TABLE login_history ADD CONSTRAINT login_history_user_id_FK FOREIGN KEY (user_id) REFERENCES users (id);