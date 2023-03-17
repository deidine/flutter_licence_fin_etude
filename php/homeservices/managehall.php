<?php
    include_once "scripts/checklogin.php";
    include_once "include/header.php";
    include_once "scripts/DB.php";

    if (!check($_SESSION['username'])) {
        header('Location: logout.php');
        exit();
    }

    $stmt = DB::query("SELECT * FROM comments");

    $providers = $stmt->fetchAll(PDO::FETCH_OBJ);

    include_once "msg/managehall.php";
?>
<div class="container" style="margin-top: 30px; margin-bottom: 60px;">
    <div class="table-responsive">
        <table class="table">
            <tr>
                <th>id commende</th>
                <th>id utulisateur</th>
                <th>id administrateur</th>
                <th>favoriser</th>
              
                <th>Action</th>
            </tr>
            <?php foreach ($providers as $provider): ?>
            <tr>
                
            
                <td><?= $provider->com_id; ?>
                </td>
                <td><?= $provider->user_id; ?>
                </td>
                <td>
                    <?= $provider->admin_id; ?><br>
                  </td>
                <td>   
                    <?= $provider->fav; ?><br>
                  </td>
                <td>
                    <form action="deletehall.php" method="post">
                        <input type="hidden" name="id"
                            value="<?= $provider->com_id ;?>">
                        <button type="submit" name="remove" class="btn btn-danger btn-block">Remove</a>
                    </form>
                </td>
            </tr>
            <?php endforeach; ?>
        </table>
    </div>
</div>

<?php include_once "include/footer.php";
