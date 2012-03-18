<h1><a href="../"><?php echo $this->eprint($this->forum['cat']); ?></a> &raquo; <?php echo $this->eprint($this->forum['name']); ?></h1>
<div class="description"><?php echo $this->eprint($this->forum['desc']); ?></div>
<div id="threads">
  <?php $this->display('forum/paging.tpl.php'); ?>
  <ul>
  <?php foreach ($this->forum['threads'] as $thread): ?>
    <li>
      <a href="<?php echo $this->eprint($thread['id']); ?>/">
        <?php echo $this->eprint($thread['title']); ?>
      </a> by 
      <a href="<?php echo BETA_ROOT_URL; ?>/profile/<?php echo $this->eprint($thread['author']); ?>/">
        <?php echo $this->eprint($thread['author']); ?>
      </a>
    </li>
  <?php endforeach; ?>
  </ul>
  <?php $this->display('forum/paging.tpl.php'); ?>
</div>
