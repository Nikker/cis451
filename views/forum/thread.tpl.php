<h1><a href="../../"><?php echo $this->eprint($this->thread['forum']['cat']); ?></a> 
  &raquo; <a href="../">
    <?php echo $this->eprint($this->thread['forum']['name']); ?>
  </a> 
  &raquo; <?php echo $this->eprint($this->thread['title']); ?>
</h1>
<div id="posts">
  <?php foreach ($this->thread['posts'] as $post): ?>
    <div class="post">
      <div class="author"><a href="<?php echo BETA_ROOT_URL; ?>/profile/<?php echo $this->eprint($post['author']); ?>/">
        <?php echo $this->eprint($post['author']); ?>
      </a></div>
      <div class="time"><?php echo $this->eprint($post['time']); ?></div>
      <div class="content"><?php echo $this->eprint($post['content']); ?></div>
    </div>
  <?php endforeach; ?>
</div>
