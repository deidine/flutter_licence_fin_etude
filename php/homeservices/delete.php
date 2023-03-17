<?php

include_once "scripts/checklogin.php";
include_once "scripts/helpers.php";
include_once "scripts/DB.php";

if (!check($_SESSION['username'])) {
    header('Location: logout.php');
    exit();
}
if (isset($_GET['id'])) {
    $input = clean($_GET);
    
    $isRemoved = DB::query("DELETE FROM `users` WHERE id=?", [$input['id']]);

    if ($isRemoved) {
        header('Location: users.php?msg=success');
        exit();
    } else {
        header('Location: users.php?msg=failed');
        exit();
    }
}
