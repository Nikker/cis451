<h1>Character Profile: <?php $this->eprint($this->character->name); ?>
  <?php if (current_user_can_edit_character($this->character->name)): ?>
    <span class="edit"><a href="edit/">(edit description)</a></span>
  <?php endif; ?>
</h1>
<div id="character">
  <img src="http://beta.shukumei.org/images/pets/<?php $this->eprint($this->character->species_slug); ?>_<?php $this->eprint($this->character->color_slug); ?>.png" alt="" />
  <ul>
    <li>Owner: 
      <?php if(property_exists($this->character, 'owner')): ?>
        <a href="<?php echo BETA_ROOT_URL; ?>/user/<?php $this->eprint($this->character->owner); ?>/"><?php $this->eprint($this->character->owner); ?></a>
      <?php else: ?>
        no owner
      <?php endif; ?>
    </li>
    <li>Species: <?php $this->eprint($this->character->species_name); ?></li>
    <li>Color: <?php $this->eprint($this->character->color_name); ?></li>
    <li>Date created: <?php $this->eprint($this->character->created); ?></li>
  </ul>
  <?php if (property_exists($this->character, 'content')): ?>
    <div class="content">
      <?php $this->eprint($this->character->content); ?>
    </div>
  <?php else: var_dump($this->character); ?>
  <?php endif; ?>
</div>
