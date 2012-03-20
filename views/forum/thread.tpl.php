<h1><a href="../../"><?php $this->eprint($this->thread['cat']); ?></a> 
  &raquo; <a href="../">
    <?php $this->eprint($this->thread['forum']); ?>
  </a> 
  &raquo; <?php $this->eprint($this->thread['title']); ?>
</h1>
<div id="posts">
  <?php if (empty($this->thread['posts'])): ?>
    <p>There are no posts in this thread...</p>
  <?php else: ?>
    <?php $this->display('paging.tpl.php'); ?>
    <?php foreach ($this->thread['posts'] as $post): ?>
      <div class="post" id="post<?php echo intval($post['id']); ?>">
        <div class="author"><a href="<?php echo BETA_ROOT_URL; ?>/user/<?php $this->eprint($post['author']); ?>/">
          <?php $this->eprint($post['author']); ?>
        </a></div>
        <div class="time"><?php $this->eprint($post['time']); ?></div>
        <div class="content"><?php echo nl2br($this->escape($post['content'])); ?></div>
      </div>
    <?php endforeach; ?>
    <?php $this->display('paging.tpl.php'); ?>
  <?php endif; ?>
  <form action="" method="POST">
    <h2>New Reply</h2>
    <?php if (property_exists($this, 'form_error')): ?>
      <div class="error">
        <div class="title">Error</div>
        <p><?php $this->eprint($this->form_error); ?></p>
      </div>
    <?php endif; ?>
    <ul>
      <li><textarea name="content"><?php
        if (array_key_exists('content',$_POST)) $this->eprint($_POST['content']);
      ?></textarea></li>
      <li><input type="submit" value="Post New Thread" /></li>
    </ul>
  </form>
</div>
