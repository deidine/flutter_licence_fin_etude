<?php
include_once "scripts/checklogin.php";
include_once "include/header.php";
include_once "scripts/DB.php";

if (!check($_SESSION['username'])) {
    header('Location: logout.php');
    exit();
}
$sql="SELECT * from users where id=?";
$bookings = DB::query($sql,[$_GET['id']])->fetchAll(PDO::FETCH_OBJ);

if ($bookings === false) {
    header('Location: index.php');
    exit();
}
?>
<div class="container" style="margin-top: 30px; margin-bottom: 60px;">
    <div class="card">
        <div class="card-body">
            <div class="card-title">
                <h3 class="text-center">Update Marriage Hall Information</h3>
            </div>
            <hr>

            <form action="upuser.php" method="post" enctype="multipart/form-data">
                <div class="form-group">
                <label for="">id</label>
                    <input value="<?= $bookings[0]->id; ?>" 
                        name="id" type="number" class="form-control" >
                </div>
                 <label for="">nom</label>
                    <input value="<?= $bookings[0]->username; ?>" 
                        name="name" type="text" class="form-control" placeholder="Name" required>
                </div> 
                <label for="">prenom</label>
                    <input value="<?= $bookings[0]->lastname; ?>" 
                        name="lastname" type="text" class="form-control" placeholder="Name" required>
                </div>
            
                <div class="form-group">
                    <label for="">telephone</label>
                    <input value="<?= $bookings[0]->tel; ?>"
                        id="contact" name="telephone" type="number" class="form-control" placeholder="Contact" required>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col-2 text-center">
                            <img style=" height: 100px;"
                                src="storage/<?= $bookings[0]->img; ?>">
                            <div class="text-center">Old Photo</div>
                        </div>
                        <div class="col">
                            <label for="">New Photo</label>
                            <input id="photo" name="photo" type="file" class="form-control-file"
                                placeholder="Select Photo 1" >
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="">Password</label>
                    <input value="<?= $bookings[0]->password; ?>"
                        id="password" name="password" type="password" class="form-control"
                        placeholder="Enter 6 Charectar Password" minlength="4" required>
                </div>

               
               

                <button style="margin-top: 20px;" class="btn btn-success btn-block" type="submit" name="register"
                    id="register">Update</button>
            </form>

        </div>
    </div>
</div>

<?php include_once "./include/footer.php";
