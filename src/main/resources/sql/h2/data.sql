-- ================================================================================
-- 초기 데이터 삽입 스크립트
-- ================================================================================

INSERT INTO BOARDS (
    NAME,
    DESCRIPTION,
    SORT,
    UPDATED_AT
) VALUES (
    '자유 게시판',
    '커뮤니티 공간',
    1,
    NOW()
);


INSERT INTO BOARDS (
    NAME,
    DESCRIPTION,
    SORT,
    UPDATED_AT
) VALUES (
    '공지사항',
    '서비스 관련 공지글 확인 공간',
    2,
    NOW()
);




