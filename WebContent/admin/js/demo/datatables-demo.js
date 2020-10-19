// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTable').DataTable();
  // https://datatables.net/examples/server_side/simple.html
  // 서버 사이드 렌더링
  /* $('#dataTable').DataTable({
     "processing": true,
     "serverSide": true,
     "ajax": "scripts/server_processing.php"
   });*/
   //
   //http://blog.naver.com/PostView.nhn?blogId=software705&logNo=220951565082
   //https://rollupcat.tistory.com/entry/javascript-DataTables를-String-Boot와-같이-사용하기
   //https://kutar37.tistory.com/entry/Grid-라이브러리Datatables-사용법예제
   //https://yuien.tistory.com/entry/DataTable-서버-사이드-CSV-전체-다운로드
});
