
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
<link href="css/viewStatisticsTotalContent.css" rel="stylesheet"
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
		<!-- <div id="line_top_x"></div> -->
		<div class="content-text">
			<table>
				<thead>
					<tr>
						<th>총 회원 수</th>
						<th>총 게시글 수</th>
						<th>총 조회 수</th>
						<th>총 방문자 수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${requestScope.totalList.getTotalMemberCount() }</td>
						<td>${requestScope.totalList.getTotalBoardCount() }</td>
						<td>${requestScope.totalList.getTotalViewCount() }</td>
						<td>${requestScope.totalList.getTotalVisitorsCount() }</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- <script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
		google.charts.load('current', {
			'packages' : [ 'line' ]
		});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {

			var data = new google.visualization.DataTable();
			data.addColumn('number', 'Day');
			data.addColumn('number', 'Guardians of the Galaxy');
			data.addColumn('number', 'The Avengers');
			data.addColumn('number', 'Transformers: Age of Extinction');

			data.addRows([ [ 1, 37.8, 80.8, 41.8 ], [ 2, 30.9, 69.5, 32.4 ],
					[ 3, 25.4, 57, 25.7 ], [ 4, 11.7, 18.8, 10.5 ],
					[ 5, 11.9, 17.6, 10.4 ], [ 6, 8.8, 13.6, 7.7 ],
					[ 7, 7.6, 12.3, 9.6 ], [ 8, 12.3, 29.2, 10.6 ],
					[ 9, 16.9, 42.9, 14.8 ], [ 10, 12.8, 30.9, 11.6 ],
					[ 11, 5.3, 7.9, 4.7 ], [ 12, 6.6, 8.4, 5.2 ],
					[ 13, 4.8, 6.3, 3.6 ], [ 14, 4.2, 6.2, 3.4 ] ]);

			var options = {
				chart : {
					title : 'Box Office Earnings in First Two Weeks of Opening',
					subtitle : 'in millions of dollars (USD)'
				},
				width : 900,
				height : 500,
				axes : {
					x : {
						0 : {
							side : 'top'
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

				$('#main').children().remove();

				// main 영역 교체

				$('#main').html(data);
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