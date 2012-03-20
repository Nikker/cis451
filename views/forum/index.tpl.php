<h1>Forums</h1>
<div id="forums">
<?php if (empty($this->categories)): ?>
  <p>There are no forums in our database for you to post on!</p>
<?php else: ?>
  <?php foreach ($this->categories as $cat): ?>
    <div class="category">
      <h2><?php echo $this->eprint($cat['name']); ?></h2>
      <?php foreach ($cat['forums'] as $forum): ?>
        <div class="forum">
          <h3><a href="<?php echo $this->eprint($forum['slug']); ?>/"><?php echo $this->eprint($forum['name']); ?></a></h3>
          <div class="description"><?php echo $this->eprint($forum['description']); ?></div>
        </div>
      <?php endforeach; ?>
    </div>
  <?php endforeach; ?>
<?php endif; ?>
</div>
