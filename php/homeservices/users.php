<?php
    include_once "scripts/checklogin.php";
    include_once "scripts/DB.php";
    include_once "include/header.php";

    if (!check($_SESSION['username'])) {
        header('Location: logout.php');
        exit();
    }

  $sql = "SELECT * from users ORDER BY id DESC";

    $bookings = DB::query($sql)->fetchAll(PDO::FETCH_OBJ);


    include_once "msg/admin.php";
?>
<div class="container" style="margin-top: 30px; margin-bottom: 60px;">
    <h2 class="text-center"> Bookings </h2>
    <div class="table-responsive">
        <table class="table">
            <tr>
                <th>nomet prenom</th>
                <th>telephone</th>
                <th>password</th>
                <th>image</th>
                
                <th>suprimer</th><th>modfier</th>
                 </tr>
            <?php foreach ($bookings as $booking): ?>
            <tr>
                <td>
                    <?= $booking->username; ?> <?= $booking->lastname; ?>
                </td>
                <td>
                    <?= $booking->tel; ?>
                </td>
                <td>
                    <?= $booking->password; ?>
                </td>
                <td>
                    <?= $booking->img; ?>
                </td>
                <td>
                    <a class="btn btn-danger"
                        href="delete.php?id=<?= $booking->id; ?>">Remove</a>
                </td>
                <td> <a class="btn btn-danger"
                        href="moduser.php?id=<?= $booking->id; ?>">update</a></td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</div>

<?php include_once "include/footer.php";
