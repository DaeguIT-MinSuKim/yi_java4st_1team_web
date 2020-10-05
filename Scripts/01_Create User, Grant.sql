-- Hairrang 계정 생성
CREATE USER hairrang_web IDENTIFIED BY rootroot;

-- Hairrang 권한 부여
GRANT CONNECT, DBA, RESOURCE TO HAIRRANG_WEB;

-- 현재 접속 계정 조회
SELECT USER
FROM dual;


-- 필요시 쓰세요. 헤어랑 계정 삭제 및 모든 정보 삭제.
SELECT *
FROM USER_SEQUENCES;

SELECT *
FROM TABS;

DROP USER HAIRRANG_WEB CASCADE;
