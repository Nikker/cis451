<h1><?php $this->eprint($this->user->username); ?>'s Profile
  <?php if (current_user_can_edit_profile($this->user->username)): ?><span class="edit"><a href="edit/">(edit profile)</a></span><?php endif; ?>
</h1>
<div id="profile">
<?php if ($this->user->content): ?>
  <div class="content section">
    <?php echo nl2br($this->escape($this->user->content)); ?>
  </div>
<?php endif; ?>
  <div class="details section">
    <h2>Details</h2>
    <ul> 
      <li>Name: <?php $this->eprint($this->user->name); ?></li>
      <li>Gender: <?php $this->eprint($this->user->gender); ?></li>
      <li>Member since: <?php $this->eprint($this->user->join_date); ?></li>
      <li>Last online: <?php $this->eprint($this->user->join_date); ?></li>
      <li>Forum posts: <?php $this->eprint($this->user->forum_posts); ?></li>
      <li>Roles: 
        <?php if (empty($this->user->roles)): ?>
          (none)
        <?php else:
          $this->eprint(implode(', ', $this->user->roles));
        endif; ?>
      </li>
    </ul>
  </div>
  <?php if (!empty($this->user->characters)): ?>
  <div class="characters section">
    <h2>Characters</h2>
    <ul>
      <?php foreach ($this->user->characters as $char): ?>
        <li class="character">
          <a href="<?php echo BETA_ROOT_URL; ?>/char/<?php $this->eprint($char->name); ?>/">
            <div class="image">
              <img src="http://beta.shukumei.org/images/pets/small_<?php $this->eprint($char->species); ?>_<?php $this->eprint($char->color); ?>.png" alt="" />
            </div>
            <div class="name"><?php $this->eprint($char->name); ?></div>
          </a>
        </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <?php endif; ?>
</div>
