<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/myShop/css/text.css" rel="stylesheet">
<title></title>
</head>
<body>
	<!-- Area Chart -->
	<div class="col-xl-8 col-lg-7">
		<div class="card shadow mb-4">
			<div class="card-header py-3 d-flex flex-row align-items-center">
				<h6>월수입(백)원</h6>
			</div>
			<!-- 월별 내용 -->
			<div class="card-body">
				<div class="chart-area">
					<canvas id="myAreaChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	<!-- Page level custom scripts -->
	<script src="/myShop/js/chart-area-demo.js"></script>

</body>
</html>