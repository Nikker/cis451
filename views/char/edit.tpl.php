<h1>Edit <a href="../"><?php $this->eprint($this->character->name); ?></a>'s Description</h1>
<form action="" method="POST" id="edit_char_desc">
  <?php $this->display('form-error.tpl.php'); ?>
  <ul>
    <li>
      <textarea name="content"><?php 
        $this->eprint(array_key_exists('content', $_POST)? $_POST['content'] : $this->character->content); 
      ?></textarea>
    </li>
    <li>
      <input type="submit" value="Edit Description" />
    </li>
  </ul>
</form>
