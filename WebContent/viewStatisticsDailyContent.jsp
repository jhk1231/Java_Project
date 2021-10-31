
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Content</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="css/viewMainContent.css" rel="stylesheet" type="text/css">
<link href="css/viewStatisticsDailyContent.css" rel="stylesheet"
	type="text/css">
</head>
<body>
	<div class="content-inner">
		<div class="content-header">
			<table>
				<tr>
					<td
						onclick="location.href='${pageContext.request.contextPath}/managerStatisticsDaily.do'">일일
						통계</td>
					<td
						onclick="location.href='${pageContext.request.contextPath}/managerStatisticsTotal.do'">총
						통계</td>
				</tr>
			</table>
		</div>
		<!-- <div id="line_top_x" class="chart-style"></div> -->
		<div class="content-text">
			<table>
				<thead>
					<tr>
						<th>날짜</th>
						<th>일일 게시글 수</th>
						<th>일일 방문자 수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="daily" items="${requestScope.dailyList}"
						varStatus="status">
						<tr>
							<td>${daily.getDailyDate() }</td>
							<td>${daily.getDailyBoardCount() }</td>
							<td>${daily.getDailyVisitorsCount() }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- <script>
		function getParameter(name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
					.exec(location.search);
			return results === null ? "" : decodeURIComponent(results[1]
					.replace(/\+/g, " "));
		}
	</script>
	<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {
			'packages' : [ 'line' ]
		});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('number', '날짜');
			data.addColumn('number', '일일 게시글 수');
			data.addColumn('number', '일일 방문자 수');

			data.addRows([ [ 1, 37.8, 80.8 ], [ 2, 30.9, 69.5 ],
					[ 3, 25.4, 57 ], [ 4, 11.7, 18.8 ], [ 5, 11.9, 17.6 ],
					[ 6, 8.8, 13.6 ], [ 7, 7.6, 12.3 ] ]);

			var options = {
				chart : {
					title : '',
					subtitle : ''
				},
				width : 1000,
				height : 400,
				axes : {
					x : {
						0 : {
							side : 'bottom'
						}
					}
				}
			};

			var chart = new google.charts.Line(document
					.getElementById('line_top_x'));

			chart.draw(data, google.charts.Line.convertOptions(options));
		}
	</script> -->

	<script>
		function daily(url) {

			// ajax option

			var ajaxOption = {

				url : url,

				async : true,

				type : "POST",

				dataType : "html",

				cache : false

			};

			$.ajax(ajaxOption).done(function(data) {

				// main 영역 삭제

				$('.main').children().remove();

				// main 영역 교체

				$('.main').html(data);
				$('.content-text').text("여기는 일일통계");

			});

		}
		function total(url) {

			// ajax option

			var ajaxOption = {

				url : url,

				async : true,

				type : "POST",

				dataType : "html",

				cache : false

			};

			$.ajax(ajaxOption).done(function(data) {

				// main 영역 삭제

				$('#main').children().remove();

				// main 영역 교체

				$('#main').html(data);
				$('.content-text').text("여기는 총통계");

			});

		}
	</script>
</body>
</html>