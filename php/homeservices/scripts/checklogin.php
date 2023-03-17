<?php

require_once 'session.php';

function check($type )
{
if(isset($_SESSION['username'])){
    return true;
    }else{
    return false;
    }}