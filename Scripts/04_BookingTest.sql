/*예약 단계
 *1. 예약 접수
 *2. 예약 완료
 *0. 예약 취소
 *3. 방문 완료
 *-1. NOSHOW
 *
 *NOSHOW 누적시 패널티 같은 거..? 별도 관리..
 */

SELECT * FROM BOOKING;

SELECT * FROM BOOKING WHERE BOOK_NO = 60 AND GUEST_ID = 'test';

SELECT * FROM event;