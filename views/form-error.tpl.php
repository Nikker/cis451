<?php if (property_exists($this, 'form_error')): ?>
  <div class="error">
    <div class="title">Error</div>
    <p><?php echo $this->eprint($this->form_error); ?></p>
  </div>
<?php endif; ?>
