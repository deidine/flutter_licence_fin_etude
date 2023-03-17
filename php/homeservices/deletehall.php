<?php

include_once "scripts/checklogin.php";
include_once "scripts/helpers.php";
include_once "scripts/DB.php";

if (!check($_SESSION['username'])) {
    header('Location: logout.php');
    exit();
}
if (isset($_POST['remove'])) {
    $input = clean($_POST);
    
    $isRemoved = DB::query("DELETE FROM comments WHERE com_id=?", [$input['id']]);

    if ($isRemoved) {
        header('Location: managehall.php?msg=success');
        exit();
    } else {
        header('Location: managehall.php?msg=failed');
        exit();
    }
}
