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

CREATE OR REPLACE PROCEDURE UPDATE_JOB_BOOKING_STATUS
   IS
      BEGIN
       -- 예약 날짜 지나감 -> 미방문
	  	UPDATE booking SET book_status = -1 WHERE trunc(book_time) < trunc(sysdate) AND book_status = 1;
      END;

-- job 생성
DECLARE
   X NUMBER;
BEGIN
   SYS.DBMS_JOB.SUBMIT
   (
   JOB => X
   , WHAT => 'UPDATE_JOB_BOOKING_STATUS;' -- 등록할 프로시저 명 넣어주기 (마지막에 꼭 ; 넣어주기. job 실행하면서 에러 날 수 있음)
   , NEXT_DATE => SYSDATE -- 현재시각부터 바로 시작
   , INTERVAL => 'TRUNC(SYSDATE) + 1' -- 매일 자정 실행
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
SELECT JOB FROM USER_JOBS WHERE WHAT = 'UPDATE_JOB_EVENT;';
SELECT JOB FROM USER_JOBS WHERE WHAT = 'UPDATE_JOB_BIRTHDAY_COUPON;';
SELECT JOB FROM USER_JOBS WHERE WHAT = 'UPDATE_JOB_BOOKING_STATUS;';

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
BEGIN
   DBMS_JOB.REMOVE(27);
   COMMIT;
END;

-- 작업 비활성화 
BEGIN
   DBMS_JOB.BROKEN(36, false);
   COMMIT;
END;
