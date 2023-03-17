<?php

require_once 'session.php';
require_once 'DB.php';
require_once 'helpers.php';

if (isset($_POST['login'])) {
    $input = clean($_POST);
    $user = $input['username'];
    $password = $input['password'];
        $stmt = DB::query(
            "SELECT * FROM admin WHERE username=? AND password=?",
            [$user , $password]
        );
        $provider = $stmt->fetch(PDO::FETCH_OBJ);

        if (isset($provider->username  )) {
            $_SESSION['username'] = $provider->username;
            header('Location: ../admin.php');
            exit();
        } else {
            header('Location: ../login.php?msg=failed');
            exit();
        }}



        if (isset($_POST['update'])) {

        $stmt = DB::query(
            "SELECT * FROM admin WHERE username=? AND password=?",
            [$user , $password]
        );
        $provider = $stmt->fetch(PDO::FETCH_OBJ);

        if (isset($provider->username)) {
            $_SESSION['username'] = $provider;
            header('Location: ../provider.php');
            exit();
        } else {
            header('Location: ../login.php?msg=failed');
            exit();
        }
    }

