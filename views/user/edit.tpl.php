<h1>Edit <?php $this->eprint($this->user->user_id == Beta::user_id()? "Your" : $this->user->username."'s"); ?> Profile</h1>
<form action="" method="POST" id="edit-profile">
  <?php $this->display('form-error.tpl.php'); ?>
  <ul>
    <li>
      <textarea name="content"><?php 
        $this->eprint(array_key_exists('content', $_POST)? $_POST['content'] : $this->user->content); 
      ?></textarea>
    </li>
    <li>
      <input type="submit" value="Edit Profile" />
    </li>
  </ul>
</form>
