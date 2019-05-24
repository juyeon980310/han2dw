<?php
	header("Content-Type: text/html; charset=UTF-8");
	$con = mysqli_connect("localhost", "woong232", "dusdnd232", "woong232");

	$result = mysqli_query($con, "SELECT COURSE.courseID, COURSE.courseGrade, COURSE.courseTitle, COURSE.courseProfessor, COURSE.courseCredit, COURSE.courseDivide, COURSE.coursePersonnel, COURSE.courseTime FROM COURSE, SCHEDULE WHERE COURSE.courseID = SCHEDULE.courseID GROUP BY SCHEDULE.courseID ORDER BY COUNT(SCHEDULE.courseID) DESC LIMIT 5");
	$response = array();
	while($row = mysqli_fetch_array($result)){
		array_push($response, array("courseID"=>$row[0], "courseGrade"=>$row[1], "courseTitle"=>$row[2]
			, "courseProfessor"=>$row[3], "courseCredit"=>$row[4], "courseDivide"=>$row[5], "coursePersonnel"=>$row[6]
			, "courseTime"=>$row[7]));
	}

	echo json_encode(array("response"=>$response), JSON_UNESCAPED_UNICODE);
	mysqli_close($con);
?> 