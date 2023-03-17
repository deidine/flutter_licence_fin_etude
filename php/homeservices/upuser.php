<?php
include_once "scripts/checklogin.php";
include_once "include/header.php";
include_once "scripts/DB.php";
include_once "scripts/helpers.php";

if (!check($_SESSION['username'])) {
    header('Location: logout.php');
    exit();
}

if (isset($_POST['register'])) {
    $input = clean($_POST);

    $name = $input['name'];
    $lname = $input['lastname'];
    $tel = $input['telephone'];
    $password = $input['password'];
    $filename = $_FILES["photo"]["name"];
	$tempname = $_FILES["photo"]["tmp_name"];
    $folder = "storage/".$filename;

    if (move_uploaded_file($tempname, $folder)) {
        echo "Image uploaded successfully";
    }else{
        echo "Failed to upload image";
    }
 
/*$file1 = upload($photo);
    if ($file1 === false) {
        header('Location', '../register.php?msg=file');
        exit();
    }*/

    $isProviderCreated = DB::query(
        "UPDATE users SET  username=?, lastname=?, tel=?, 
        img=?,  password=? WHERE id=".$_POST['id']."",
        [$name,$lname,$tel,$filename,  $password]
    );

    if ($isProviderCreated) {
  header('Location: users.php');
     exit();
    } else {
        echo "fallse";
    
    }
}
