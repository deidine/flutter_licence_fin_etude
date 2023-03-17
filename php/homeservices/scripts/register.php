<?php

require_once 'session.php';
require_once 'DB.php';
require_once 'helpers.php';

if (isset($_POST['register'])) {
    $input = clean($_POST);

    $name = $input['name'];
    $lname = $input['lname'];
    $contact = $input['contact'];
    $password = $input['password'];
    $filename = $_FILES["photo"]["name"];
	$tempname = $_FILES["photo"]["tmp_name"];
    $folder = "../storage/".$filename;

    if (move_uploaded_file($tempname, $folder)) {
        echo "Image uploaded successfully";
    }else{
        echo "Failed to upload image";
    }
 

    $isProviderCreated = DB::query("INSERT INTO users(usrename,lastname,tel,password,img) values( ?, ?, ?, ?, ?)", [
        $name,$lname,$contact,$password,$filename
        ]);

    /*if ($isProviderCreated) {
        header('Location: ../register.php?msg=success');
        exit();
    } else {
        unlink('../storage/'.$file1);
        header('Location: ../register.php?msg=failed');
        exit();
   
} }*/
}