--
-- # H2 In-Memory DB 테이블 기본 데이터 추가
--


-- # 업무 그룹 더미 데이터 추가
INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '기획',
    1,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '요구사항 분석',
    2,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '설계',
    3,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '구현',
    4,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '테스트',
    5,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '배포',
    6,
    NOW()
);

INSERT INTO TASK_GROUPS (
    name,
    sort,
    updated_at
) VALUES (
    '유지보수',
    6,
    NOW()
);



-- # 게시판 더미 데이터 추가
INSERT INTO BOARDS (
    name,
    description,
    updated_at
) VALUES (
    '자유 게시판',
    '자유롭게 이야기를 나누는 공간',
    NOW()
)

INSERT INTO BOARDS (
    name,
    description,
    updated_at
) VALUES (
    '지식 공유',
    '질문과 대답을 자유롭게 나누거나 자신의 지식을 공유하는 공간',
    NOW()
)

INSERT INTO BOARDS (
    name,
    description,
    updated_at
) VALUES (
    '공지사항',
    '관리자만이 작성하는 공간',
    NOW()
)