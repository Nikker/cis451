<h1>Forums</h1>
<div id="forums">
<?php foreach ($this->categories as $cat): ?>
  <div class="category">
    <h2><?php echo $this->eprint($cat['title']); ?></h2>
    <?php foreach ($cat['forums'] as $forum): ?>
      <div class="forum">
        <h3><a href="<?php echo $this->eprint($forum['slug']); ?>"><?php echo $this->eprint($forum['title']); ?></a></h3>
        <div class="description"><?php echo $this->eprint($forum['desc']); ?></div>
      </div>
    <?php endforeach; ?>
  </div>
<?php endforeach; ?>
</div>
