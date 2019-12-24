<?php
$allowed_ext = array('jpg','jpeg','png','gif');

$name = $_FILES['pdf']['name'];
$error = $_FILES['pdf']['error'];
$ext = array_pop(explode('.', $name));

if(!in_array($ext, $allowed_ext)) {
	echo "허용되지 않는 확장자입니다.";
	exit;
}

if( $error != UPLOAD_ERR_OK ) {
	switch( $error ) {
		case UPLOAD_ERR_INI_SIZE:
		case UPLOAD_ERR_FORM_SIZE:
			echo "파일이 너무 큽니다. ($error)";
			break;
		case UPLOAD_ERR_NO_FILE:
			echo "파일이 첨부되지 않았습니다. ($error)";
			break;
		default:
			echo "파일이 제대로 업로드되지 않았습니다. ($error)";
	}
	exit;
}

if(move_uploaded_file($_FILES['pdf']['tmp_name'], 'uploads/'.$name)){
    echo 'uploads/'.$name;
} else {
    echo "이미지 업로드를 실패하였습니다.";
}
?>