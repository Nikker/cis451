<h1>
  <a href="../"><?php echo $this->eprint($this->forum['cat']); ?></a> 
  &raquo; <?php echo $this->eprint($this->forum['name']); ?>
</h1>
<div class="description"><?php echo $this->eprint($this->forum['description']); ?></div>
<div id="threads">
  <?php if (empty($this->forum['threads'])): ?>
    <p>There are no threads in this forum yet.  You should post one!</p>
  <?php else: ?>
    <?php $this->display('paging.tpl.php'); ?>
    <ul>
    <?php foreach ($this->forum['threads'] as $thread): ?>
      <li>
        <a href="<?php echo $this->eprint($thread['id']); ?>/">
          <?php echo $this->eprint($thread['title']); ?>
        </a> by 
        <a href="<?php echo BETA_ROOT_URL; ?>/user/<?php echo $this->eprint($thread['author']); ?>/">
          <?php echo $this->eprint($thread['author']); ?>
        </a>
      </li>
    <?php endforeach; ?>
    </ul>
    <?php $this->display('paging.tpl.php'); ?>
  <?php endif; ?>
  <form action="" method="POST">
    <h2>New Thread</h2>
    <?php $this->display('form-error.tpl.php'); ?>
    <ul>
      <li><label for="thread_title">Title</label> <input type="text" size="50" id="thread_title" name="title" value="<?php
        if (array_key_exists('title',$_POST)) echo $this->eprint($_POST['title']);
      ?>" /></li>
      <li><label for="thread_content">Content</label> <textarea id="thread_content" name="content"><?php
        if (array_key_exists('content',$_POST)) echo $this->eprint($_POST['content']);
      ?></textarea></li>
      <li><input type="submit" value="Post New Thread" /></li>
    </ul>
  </form>
</div>
