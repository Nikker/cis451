<h1>User List</h1>
<?php if (empty($this->users)): ?>
  <p>There are no users to display.</p>
<?php else: ?>
  <?php $this->display('paging.tpl.php'); ?>
  <ul>
    <?php foreach ($this->users as $user): ?>
      <li><a href="<?php $this->eprint($user->username); ?>"><?php $this->eprint($user->username); ?></a></li>
    <?php endforeach; ?>
  </ul>
  <?php $this->display('paging.tpl.php'); ?>
<?php endif; ?>
