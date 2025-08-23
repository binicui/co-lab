-- #####################################################################################################################
--  초기 데이터 삽입 스크립트 (공통 코드 및 더미 데이터 등)
-- #####################################################################################################################


-- '게시판' 데이터 삽입
INSERT INTO BOARDS (NAME, DESCRIPTION, SORT, UPDATED_AT) VALUES ('자유 게시판', '자유롭게 이야기를 나누는 공간', 1, NOW());
INSERT INTO BOARDS (NAME, DESCRIPTION, SORT, UPDATED_AT) VALUES ('공지사항', '시스템에 대한 공지를 확인하는 공간', 2, NOW());


-- '작업 그룹' 데이터 삽입
INSERT INTO TASK_GROUPS (NAME, SORT, UPDATED_AT) VALUES ('기획 및 요구사항 분석', 1, NOW());
INSERT INTO TASK_GROUPS (NAME, SORT, UPDATED_AT) VALUES ('설계', 2, NOW());
INSERT INTO TASK_GROUPS (NAME, SORT, UPDATED_AT) VALUES ('구현', 3, NOW());
INSERT INTO TASK_GROUPS (NAME, SORT, UPDATED_AT) VALUES ('테스트', 4, NOW());
INSERT INTO TASK_GROUPS (NAME, SORT, UPDATED_AT) VALUES ('유지보수', 5, NOW());