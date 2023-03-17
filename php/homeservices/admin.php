<?php
    include_once "scripts/checklogin.php";
    include_once "scripts/DB.php";
    include_once "include/header.php";

    if (!check($_SESSION['username'])) {
        header('Location: logout.php');
        exit();
    }

  $sql = "SELECT * from admin ORDER BY id DESC";

    $bookings = DB::query($sql)->fetchAll(PDO::FETCH_OBJ);


    include_once "msg/admin.php";
?>
<div class="container" style="margin-top: 30px; margin-bottom: 60px;">
    <h2 class="text-center"> Bookings </h2>
    <div class="table-responsive">
        <table class="table">
            <tr>
                <th>nom et prnom</th>
                <th>telephone</th>
                <th>password</th>
                <th>descrption</th>
                <th>id cart</th>
  <th>image</th>
                 </tr>
            <?php foreach ($bookings as $booking): ?>
            <tr>
                <td>
                    <?= $booking->username; ?> /<?= $booking->lastname; ?>
                </td>
                <td>
                    <?= $booking->tel; ?>
                </td><td>
                    <?= $booking->password; ?>
                </td> <td>
                    <?= $booking->des; ?>
                </td>
                <td>
                    <?= $booking->id_cat; ?>
                </td>
                
                <td>
                    <?= $booking->img; ?>
                </td>
                <td>
                <a class="btn btn-danger"
                        href="deladmin.php?id=<?= $booking->id; ?>">Remove</a>
                </td>
                <td> <a class="btn btn-danger"
                        href="modfier.php?id=<?= $booking->id; ?>">update</a></td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</div>

<?php include_once "include/footer.php";
