--이벤트

/*1. 10분 간격으로 실행
	SYSDATE + 1/24/6
2. 현재 시간으로 부터 하루 뒤 다음 날 현재 시간에 실행 (매일)
	SYSDATE + 1 
3. 매일 새벽 5시
	TRUNC(SYSDATE) + 1 + 5 / 24
4. 매일 밤 10시
	TRUNC(SYSDATE)  + 20 / 24
5. 1분 간격
	SYSDATE + 1/24/60*/

CREATE OR REPLACE PROCEDURE UPDATE_JOB_EVENT
   IS
      BEGIN
       -- 진행중 -> 대기
	  	UPDATE event SET event_status = 'w' WHERE event_start > sysdate;
       	-- 대기 -> 진행중으로 변경 
		UPDATE event SET event_status = 's' WHERE event_start <= sysdate AND event_end >= sysdate;
		-- 이벤트 종료로 변경
		UPDATE event SET event_status = 'e' WHERE event_end < sysdate;
		-- 고객 쿠폰 기간만료로 변경
		UPDATE coupon SET USED_YN = 'e' WHERE EVENT_END < sysdate AND USED_YN IN ('n', 'w', 'e');
		-- 대기
		UPDATE COUPON SET USED_YN = 'w' WHERE event_start > sysdate  AND USED_YN IN ('n', 'w', 'e');
		--수정했을때 기간중이면 n로,, 사용완료 (y) 제외
		UPDATE COUPON SET USED_YN = 'n' WHERE event_start <= sysdate AND event_end >= sysdate AND USED_YN IN ('n', 'w', 'e');
      END;

-- job 생성
DECLARE
   X NUMBER;
BEGIN
   SYS.DBMS_JOB.SUBMIT
   (
   JOB => X
   , WHAT => 'UPDATE_JOB_EVENT;' -- 등록할 프로시저 명 넣어주기 (마지막에 꼭 ; 넣어주기. job 실행하면서 에러 날 수 있음)
   , NEXT_DATE => SYSDATE -- 현재시각부터 바로 시작
   , INTERVAL => 'SYSDATE + 1/24/60/20' -- 3초 간격으로 실행
   , NO_PARSE => TRUE
   );
END;


/*
 * sysdate + 7         7일에 한번
 * sysdate + 1         하루에 한번
 * sysdate + 1/24      한 시간에 한번
 * sysdate + 1/24/60   1분에 한번(1/1440)
 * sysdate + 1/24/60/60   1ch(1/86400)
 * TRUNC(SYSDATE) + 1 + 5/24   매일 새벽 5시
 * TRUNC(SYSDATE) + 20/24      매일 밤 10시
 * 
 * NO_PARSE : 만약 NO_PARSE가 FALSE로 설정(이것이 기본값입니다.)되면, 오라클은 job과 연관된 프로시저를 파싱합니다. 
 * 만약 NO_PARSE가 TRUE로 설정되면, 오라클은 job과 연관된 프로시저를 job이 처음 실행될 때 파싱합니다. 예를 들어, 만약 job과 관련된 테이블이 생성되기 전에 job 을 submit 하기를 원한다면 NO_PARSE를 TRUE 로 설정하면 됩니다.
 */

-- 등록된 job 확인
SELECT * FROM USER_JOBS;

-- 마지막 실행시간, 다음 실행시간, 실행시간, 활성화 비활성화 여부, 실패 횟수, 실핼항 Object
SELECT LAST_DATE, NEXT_DATE, TOTAL_TIME, BROKEN, FAILURES, WHAT FROM USER_JOBS;


-- JOB을 강제 실행
BEGIN
   DBMS_JOB.RUN(23);
   COMMIT;
END

-- 등록되어 있는 JOB 삭제
BEGIN
   DBMS_JOB.REMOVE(63);
   COMMIT;
END;

-- 작업 비활성화 
BEGIN
   DBMS_JOB.BROKEN(36, false);
   COMMIT;
END;

---------------------------------------------------------------------------------------------------------------------------



--생일 쿠폰 => 매일체크, 지금 3초간격이니까 테스트하고 remove하삼
SELECT * FROM user_jobs; 

-- 배치(스케줄러)
-- 프로시저 생성
CREATE OR REPLACE PROCEDURE UPDATE_JOB_BIRTHDAY_COUPON
   IS
      BEGIN
	   --생일쿠폰 삽입
	  INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
--		SELECT guest_id, 1/*이벤트번호*/, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
		SELECT guest_id, 1/*이벤트번호*/, "thisyear_bd" AS event_start, "thisyear_bd" + 14 - 1 / (24*60*60) + 1 AS event_end
		FROM (
		SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest_view g
		) gb WHERE TO_CHAR(sysdate, 'YYYY-MM-DD') = TO_CHAR("thisyear_bd", 'YYYY-MM-DD');
--		) gb WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;
      END;
     

-- job 생성
DECLARE
   X NUMBER;
BEGIN
   SYS.DBMS_JOB.SUBMIT
   (
   JOB => X
   , WHAT => 'UPDATE_JOB_BIRTHDAY_COUPON;' -- 등록할 프로시저 명 넣어주기 (마지막에 꼭 ; 넣어주기. job 실행하면서 에러 날 수 있음)
   , NEXT_DATE => SYSDATE -- 현재시각부터 바로 시작 : 지금 한번 들어감
   , INTERVAL => 'SYSDATE + 1' -- 3초 간격으로 실행
   , NO_PARSE => TRUE
   );
END;


/*
 * sysdate + 7         7일에 한번
 * sysdate + 1         하루에 한번
 * sysdate + 1/24      한 시간에 한번
 * sysdate + 1/24/60   1분에 한번(1/1440)
 * sysdate + 1/24/60/60   1ch(1/86400)
 * TRUNC(SYSDATE) + 1 + 5/24   매일 새벽 5시
 * TRUNC(SYSDATE) + 20/24      매일 밤 10시
 * 
 * NO_PARSE : 만약 NO_PARSE가 FALSE로 설정(이것이 기본값입니다.)되면, 오라클은 job과 연관된 프로시저를 파싱합니다. 
 * 만약 NO_PARSE가 TRUE로 설정되면, 오라클은 job과 연관된 프로시저를 job이 처음 실행될 때 파싱합니다. 예를 들어, 만약 job과 관련된 테이블이 생성되기 전에 job 을 submit 하기를 원한다면 NO_PARSE를 TRUE 로 설정하면 됩니다.
 */

-- 등록된 job 확인
SELECT * FROM USER_JOBS;

-- 마지막 실행시간, 다음 실행시간, 실행시간, 활성화 비활성화 여부, 실패 횟수, 실핼항 Object
SELECT LAST_DATE, NEXT_DATE, TOTAL_TIME, BROKEN, FAILURES, WHAT FROM USER_JOBS;


-- JOB을 강제 실행
BEGIN
   DBMS_JOB.RUN(65);
   COMMIT;
END;

-- 등록되어 있는 JOB 삭제
BEGIN
   DBMS_JOB.REMOVE();
   COMMIT;
END;

-- 작업 비활성화 
BEGIN
   DBMS_JOB.BROKEN(77, TRUE);
   COMMIT;
END;

